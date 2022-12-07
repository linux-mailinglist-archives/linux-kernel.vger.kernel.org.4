Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF5645542
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLGINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLGIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:12:59 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D9B85
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:12:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f16so8348772ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 00:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+kjYDptxUK/6lTIYvf1c81EedOZ9qW05fricFulF/s=;
        b=E+Idr6D8UHCLzDMlof82wLQ953lks4pkn/ITiOLjg5EZ5GexMPBGhRyhZ47WjQBA5x
         ZtTgp/uA7mD1SKC0qk623g9FPnNWypXTviAAbU5l3pEfxPmDG/1VYSTTOhtIg/6jfajW
         zrVRznyX8RLlWHPs8g8ldRGAAsbVi1RUEVxMSVWVVvl21z91bamPXZ1j1An/HTzDCVnN
         5Z01lDM1eiwfrSeydBjDoS9F3SM2YHUEc+91G6J9klWpmZPwxEx8ZuwA3Tb/VopOvPEM
         +BO74orO6Y27+gPuYCLB+/l1gtqg3ofRuBZy9k2qh2yT+hHXig4/E0XyBdRmJbSVIWni
         SP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+kjYDptxUK/6lTIYvf1c81EedOZ9qW05fricFulF/s=;
        b=CqGd9XsL4ObEboRi2PAly2wFVm0jsT3Rmr8UMBNYYQC5+uQ/GukCQiDrZRoSWnyUVp
         CQmUdA4GD+L1mCCYCCWbQS2tnEwkJXAFQ7ntT9GfGUe3veUi0rB/YLPO8vWy7uFgmoin
         QPhQ0bOy3IfZTixB35DziXNWSvsn2lcxItANBjDFByt//zTfjWz2v56fZis23nOnk7sF
         qUEjb4qimETcVVjNRNqVYObfwwYMuBLGmID5wF/LSHb6Z04oXdR1JBhPS5hfQIAE4IO9
         qYMNQKTGTZ7Ky8G9YvU9XoGs0NxAXm1c28w11yCMC3ItvQq4jQ57A4jEH6vdaJnoHjXR
         UHDg==
X-Gm-Message-State: ANoB5pliWBHTdUim1IywXgkLt39eOt+75v1SZNFU+KbuGBlXcWoMsTZ/
        VXYVaVggnT0v/GFPK2PzIwq2Y7jk9/9FFp7sXFJo4w==
X-Google-Smtp-Source: AA0mqf5iOn+a4tqY2SYsU+Hmzcta+/lPEAREqnH/tSE6nHz37FLIaYyTLATUxyA+pzwqdKe5qV58PXUueOsqZhvjKiY=
X-Received: by 2002:a2e:b0ef:0:b0:279:be29:cb69 with SMTP id
 h15-20020a2eb0ef000000b00279be29cb69mr11441271ljl.482.1670400776921; Wed, 07
 Dec 2022 00:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20221206144134.1919987-1-yebin@huaweicloud.com>
 <CABymUCN-WC5aCpVestRFpXVgZobxs48crUDX2419yvXxLgyjRQ@mail.gmail.com> <63904686.3010903@huawei.com>
In-Reply-To: <63904686.3010903@huawei.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 7 Dec 2022 16:11:01 +0800
Message-ID: <CABymUCMC=8PwrqetiOBVK98iwKrycAf_eYZdfqVOPya6jZTPvQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yebin (H) <yebin10@huawei.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=B8=89 15:54=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/12/7 14:44, Jun Nie wrote:
> > Hi Bin,
> >
> > Thanks for the patch! The bug is reproduced with this patch. I can
> > help trigger another
> > test when you have new patch.
> > https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D16760797880000
>
> The cause of this issue is different from that of the previous issue.
> I analyze that the issue
> "https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D16760797880000 "
> is caused by the concurrency of  inline data conversion and buffer
> write. To be honest, I haven't
> thought of any good solution.
>
Thanks for explanation. So the patch to fix the previous bug is still
in upstream plan, right?
> >
> > Regards,
> > Jun
> > .
>
