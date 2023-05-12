Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679F6FFF41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjELDZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjELDZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE51BC9;
        Thu, 11 May 2023 20:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3608264DA2;
        Fri, 12 May 2023 03:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95252C433D2;
        Fri, 12 May 2023 03:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683861950;
        bh=cTBnLy3eQku5I3kq4VRmAiy3V6kmgt0B+3aiC8bEzrs=;
        h=From:Date:Subject:To:Cc:From;
        b=N0YskMbCr/s51e6Run2XBWc60UFbGTLquAPlTV1KT+TKezFxBUYwV+K1noDlWjukv
         JjzxSGFF94c2t0IcYM0YPyu8cZYyF+AHNd5c7CBpSgemiJI/Kpqz9qH6WFnuzR4v2K
         dh3Dopyxmyh4VsfExbTlSVCBGzSWtlVBf91NYJAO1d4j+rOT3tr4HkRpTBd1dEPPHT
         ie6qoKQ6llzGrGtCH2dmNt6pQjTmYwTFWbWkg8486WtB3MPtk+Fzwug1FTzPF1bk3W
         JTIUepOMDsFSdjkPK2E2WDOk1z5BtcaBN61ni/7t6MfRZpzpOLzdHrgQLobe0vowym
         DcvMQWndQ6MGA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-394690088acso350527b6e.0;
        Thu, 11 May 2023 20:25:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDy2kP0SjKDWGY89dAiND3ht0q8a/caEn9cRq0lHZzh7wIKY11UY
        PPL6M2JnY5cxMlh7WMLC63wrk6j5xTlVG1rd51g=
X-Google-Smtp-Source: ACHHUZ7FKGH/MsHNwX2k2oJZmwSIuQOC62sHk5vs1GTkT0CfeaKv4ffQvjUNa9A+b87YK+Txa9pnVkHv0iZu86Zh6gE=
X-Received: by 2002:a05:6808:23c2:b0:394:65f4:f146 with SMTP id
 bq2-20020a05680823c200b0039465f4f146mr1762400oib.5.1683861949904; Thu, 11 May
 2023 20:25:49 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 12 May 2023 12:25:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATrFbr7kT9HEFgYO6ZstaSx1FB+Q4SQrAX+D8VwG5K0dQ@mail.gmail.com>
Message-ID: <CAK7LNATrFbr7kT9HEFgYO6ZstaSx1FB+Q4SQrAX+D8VwG5K0dQ@mail.gmail.com>
Subject: [RFC] [kbuild test robot] random-order parallel building
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, maintainers of the kbuild test robot.

I have a proposal for the 0day tests.


GNU Make traditionally processes the dependency from left to right.

For example, if you have dependency like this:

     all: foo bar baz

GNU Make builds foo, bar, baz, in this order.


Some projects that are not capable of parallel builds
rely on that behavior implicitly.

Kbuild, however, is intended to work well in parallel.
(As the maintainer, I really care about it.)


From time to time, people add "just worked for me" code,
but apparently that lacks proper dependency.
Sometimes it requires an expensive CPU to reproduce
parallel build issues.


For example, see this report,
  https://lkml.org/lkml/2016/11/30/587

The report says 'make -j112' reproduces the broken parallel build.
Most people do not have such a build machine that comes with 112 cores.
It is difficult to reproduce it (or even notice it).

(Some time later, it was root-caused by 07a422bb213a)



GNU Make 4.4 got this option.

  --shuffle[={SEED|random|reverse|none}]
       Perform shuffle of prerequisites and goals.



'make --shuffle=reverse' will build in reverse order.
In the example above, baz, bar, foo.

'make --shuffle' will randomize the build order.


If there exists a missing dependency among foo, bar, baz,
it will fail to build.



We already perform the randconfig daily basis.
So, random-order parallel building is a similar idea.

Perhaps, it makes sense to add the "--shuffle=SEED" option
but it requires GNU Make 4.4.  (or GNU Make 4.4.1)
Is this too new?



--
Best Regards
Masahiro Yamada
