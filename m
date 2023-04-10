Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240D6DC6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDJM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDJM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CDC5B99;
        Mon, 10 Apr 2023 05:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A33B61277;
        Mon, 10 Apr 2023 12:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8F0C4339B;
        Mon, 10 Apr 2023 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681129629;
        bh=KufX/rFw1L8RO7Ul1M2Nhx7Gyo1LMI3KWekXsauBMQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N3OT+B+YtJvnqoq+FiB9uzlmADHAJmT2VaL8DPOTSQW7TOShS/V/SXTXVpRBqC3vi
         IdYYULn9eu35CyVXNvwamL+htgAmuVJtTtmJcBlpY5jK/amocP608K0tuYAODCSFG/
         BGWSJz4PRtWfHc4aRU0LPI0U+q7K8Kq8icBCLVP3osGPcESDkDFagt0SzGtm0J8oEn
         XxO4H48/yI3FSXAxCXUAPoGBsWfG7MhMNSxslsXqardAOkfakt0nSZAbB+2RcguQGi
         zHHyPH0ywB3NyqAbfHefifP9AfmyiIQaVZc1n7ThQsCa33WaKzF8BgsxVOUJf1vPOo
         biRXpZDvwFS6Q==
Received: by mail-oo1-f47.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso1640920oom.6;
        Mon, 10 Apr 2023 05:27:09 -0700 (PDT)
X-Gm-Message-State: AAQBX9eCzTntzmT0zX7Ot+6Jj/tP5VNpWuVuWXB/SVn084hgb39Ppb1H
        yWpsR/0zbPkUFuu47pyAd6Xp3lf8KhQeOXpfi+8=
X-Google-Smtp-Source: AKy350auc2CXgCmBKzPuc9DEIKLHQzDdPTZ5CNDzD3XSwJMMoyx76G0PGdfri7Zuh6ehc2caZWzS1PkHxuDN02um0PA=
X-Received: by 2002:a4a:e543:0:b0:541:c009:5b28 with SMTP id
 s3-20020a4ae543000000b00541c0095b28mr1798977oot.1.1681129628768; Mon, 10 Apr
 2023 05:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230315173524.63179-1-bage@linutronix.de> <20230315173524.63179-2-bage@linutronix.de>
 <CAK7LNASckF_6QLHkvLEk3b8nE23v4Qy4wmm4FHd5BrDo6U2x2g@mail.gmail.com> <4be55ba4-d3fa-dfa9-7b38-13f3ced20ad2@linutronix.de>
In-Reply-To: <4be55ba4-d3fa-dfa9-7b38-13f3ced20ad2@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 Apr 2023 21:26:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpLA+0bVA=iu4bUOc4aXhX4Qc8sEYd+37aF0ZCyuWvUQ@mail.gmail.com>
Message-ID: <CAK7LNARpLA+0bVA=iu4bUOc4aXhX4Qc8sEYd+37aF0ZCyuWvUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] kbuild: deb-pkg: Build parallely with current dpkg-buildpackage
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 7:28=E2=80=AFPM Bastian Germann <bage@linutronix.de=
> wrote:
>
> Am 21.03.23 um 11:18 schrieb Masahiro Yamada:
> > "make bindeb-pkg" also runs in 16 threads because
> > $(DEB_BUILD_OPTIONS) always contains "parallel=3D16"
> > even if -j<N> option is given at all.
> >
> > In other words, this patch will take away user's freedom
> > to choose the number of threads.
>
> Okay. To solve this, I would forward make's -j option to the dpkg-buildpa=
ckage calls,
> which is now called with the defaults.

Yes. Agreed.



> I think you should see the warning with older dpkg-buildpackage versions =
without the
> patch applied as well because their default is dpkg-buildpackage -j`nproc=
` and is in
> effect currently.



--=20
Best Regards
Masahiro Yamada
