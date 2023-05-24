Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED470F998
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjEXPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjEXPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:02:38 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C7E9
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:02:36 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-19a60c9ddecso103026fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940556; x=1687532556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkTt7pUa2ZVNwy/OEsrIK++2IUTMhQoejHkdP2b+d60=;
        b=SzQiABT0rUb1935q/pEDOZjT7+V1HvDYt9PvaHid+tV+xIL+oLQg6LJSK4E+vpZgey
         gtcGSY9ogrZb5fEMvEGXL67d7oTRnC03zwS8jSZI5zYH1nl/m3c8bsS3gDdQh9S6Jy9G
         Yd5M3UQUNRYOD2uxdXkSvcVombp+XhOnIi0k5NnRWGxspKKVg5tn8Bq55gzd3eFk5SsP
         vkGqI5Dwc9hoNK5SbResGzeEhLSJilKm/3VO0H/xSv8DCkLKAuIh5p62RkMnKyK3QfoS
         qvlTseTHXFlBcRGpQ75EzHPmDT745hMpQ1+fAkw1RFxpSXpc+uhhSWqUW/N6uMYNmkN4
         mB7A==
X-Gm-Message-State: AC+VfDylfdHvWYSCzEp9Yw1EtFwolXxvez+q8R1UaHwWzCCL1whG43W+
        XDGgVJLdRkYcvl6XisoP3UqQagR0N6/ZweM68l/Dg5XpuoOF
X-Google-Smtp-Source: ACHHUZ68LW5oC+fz0KsQ4ML8Xri9cf5VSXK28NaSo2LBUG1xrm2H3fwQhE8/IZiAwX6ePa/8pxEbtZBym2jxxMNYhHWCjVM5PCCM
MIME-Version: 1.0
X-Received: by 2002:a05:6871:6b9f:b0:196:bc94:bff4 with SMTP id
 zh31-20020a0568716b9f00b00196bc94bff4mr8946oab.10.1684940556301; Wed, 24 May
 2023 08:02:36 -0700 (PDT)
Date:   Wed, 24 May 2023 08:02:36 -0700
In-Reply-To: <f309f841-3997-93cf-3f30-fa2b06560fc0@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000537fad05fc71cbb4@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in mini_qdisc_pair_swap
From:   syzbot <syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://gitlab.com/tammela/net.git/peilin-patches: failed to run ["git" "fetch" "--force" "71d757925c19d8f23c660d1e07af98f28b9c6977" "peilin-patches"]: exit status 128
fatal: read error: Connection reset by peer



Tested on:

commit:         [unknown 
git tree:       git://gitlab.com/tammela/net.git peilin-patches
dashboard link: https://syzkaller.appspot.com/bug?extid=b53a9c0d1ea4ad62da8b
compiler:       

Note: no patches were applied.
