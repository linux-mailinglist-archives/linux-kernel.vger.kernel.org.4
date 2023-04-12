Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7F6DF695
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDLNLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:11:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBE7AB1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:11:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso59455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681305075; x=1683897075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYNrGQC5b/NBqc1yQ3cYIsZNkqhxiUfUPkUBeBGXBMI=;
        b=1CZnjtbR216USXkVhbERFHDy8P7c+AU2osjSac6rHPbdfZ1vFvFhpC8NSnsnBms5yM
         ve/WfWhOsaTBOMut5gQKDeHynouskhigYhz64Uh/jmvu7HqO0dQe8SQoPknBPtZozit5
         +m0QCFmYDoIWUSceZWqW2EdwpZ8RhSffbp1dST0cR8Q4g4o3pKr6l3PMhjVc561EUbq/
         HH6huU0rL1RFwJFtwRCbNvrYq2y8pY5k5TLhOYU0gv4QMzCP7fr69CaKpq+U6jaONVkB
         qLHdWz7mNBPIAxaNX6thZHHVqNyUN70hDnR9dxnWTtJAdEHNDRboANdIZIAejOdlbmr/
         Hg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305075; x=1683897075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYNrGQC5b/NBqc1yQ3cYIsZNkqhxiUfUPkUBeBGXBMI=;
        b=JTBNcNPUnFqbeusiKe+xk+lUPAFEdrw9ARHx0q9oha24RhJQK1WcPuYd3dQRuGeYZE
         SjRDbyrRi3Vcw1+fr5KuZzCEFqJgP9js6as/ZXdxWAP1yk6XSQi3V/RARPqyIRt921XF
         4ae8tDMAzLUdwmNRroVrwlQfHeU1Go05Ov8q6G9C0EoQz8CZfWgcvzSHfMYdghTOdqQb
         7zZ/BNyWiiBW55dv2zy4zbiTgVfj4aspMy/AcOacbs3+n3ZMg3zor9gfm0kzbnlMlDt7
         IWG7cpEyIkW2243rxajW3QF2z/ZCbUv8iG1GX8XsYIOsJ/C4ao3q25F8u3+wM5ZrGvkv
         3fzw==
X-Gm-Message-State: AAQBX9cOi777NPc9dpGmFo/HlmztT4HnkQHyVmwc7pT5WKZsLxu/CFxe
        ZSZo9rTmSjbNk7Qjvkr6h4g0Wgdk+d+wwUOQd1VpsA==
X-Google-Smtp-Source: AKy350YtLCDH4ydbVdrabxsvBBFQW00tuyHb9t9bfLeg/Wd8PxHaRAFugQin3ixuS561igGxpjSQp0SgAkwMWeu5Lh8=
X-Received: by 2002:a05:600c:5125:b0:3f0:a122:93d9 with SMTP id
 o37-20020a05600c512500b003f0a12293d9mr24457wms.6.1681305075095; Wed, 12 Apr
 2023 06:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005af92105e80510f2@google.com> <0000000000002c692505f3265254@google.com>
In-Reply-To: <0000000000002c692505f3265254@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 12 Apr 2023 15:11:03 +0200
Message-ID: <CANp29Y6-1HThnB6C+p1D77n3hH1RKyD5WR+xjQomdqrc_pjUcw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_get_ea
To:     syzbot <syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, dan.carpenter@oracle.com,
        eadaivs@sina.com, eadavis@sina.com, eadvis@sina.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, ntfs3@lists.linux.dev,
        pjwatson999@gmail.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: fs/ntfs3: Check fields while reading

On Thu, Jan 26, 2023 at 9:13=E2=80=AFAM syzbot
<syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
> Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Date:   Mon Oct 10 10:15:33 2022 +0000
>
>     fs/ntfs3: Check fields while reading
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15cc619948=
0000
> start commit:   fef7fd48922d Merge tag 'scsi-fixes' of git://git.kernel.o=
r..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7341d0f941b33=
56
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc4d950787fd5553=
287b7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D133d4479880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f05e7188000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs/ntfs3: Check fields while reading
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/0000000000002c692505f3265254%40google.com.
