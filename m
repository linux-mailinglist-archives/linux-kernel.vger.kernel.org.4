Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685B45BEB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiITQ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiITQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:27:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F305C357
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:27:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id go6so3649093pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=nozjIQsweFuPzfXtraNdAM+jAee1LTWuryMIowXVdmM=;
        b=hcEk8juE0EYct1W9g0P5fcYEALarG90oOtjn08jXv5BzEET3M/kbyEQPjqLRz/3NJ7
         kAjluUeQ7up2kZp9CzJLJvViy81CE1kXM3aZ7KmiPsangwrugNyzEqh8W/OUISBCKwnz
         qtEsi1c9TqKYmxI6Z6bAzkIrGRRGkb+9AmqWrJksO3tW7Sb8XqvuvqWIlTyWwMyobshT
         L3TbCLZxjI6Tk/X1Yw7wl4fz0rVSIPUSPk95eSYRvz7zR2tBoEkxyvBLQZkMybawTQEl
         nUZ8/8s/AxnZfebI+vMVbv3tJz2V8Jq/bwFzIjJMEoy0VxRF3kHfwXrXYvUCLdU4xNhd
         k9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nozjIQsweFuPzfXtraNdAM+jAee1LTWuryMIowXVdmM=;
        b=MwgetEm6w0gUOPzbyne063FV4utoE1wBdGcJlgIZE1+KC9dyLj1ab51HFB7NVANQBJ
         i3fW/NP6jzw4bW/P3zBxLyiD8fQUUJ6nrOgRGel2Ly1gigVguvJaLx2I0+EfgaQ3KP7z
         CqxSUzMWdQixCjdPaSU67mhVgwExa49GvhgTd02dNo3fbBOjR2Sw2l/Pw1ZGdtZRyKXL
         fRHoXnM72/cH93DuPIdRDp3qK9bZSYL7I2f85Hme95th9kzjlZr2A1+A6mXhyqfwy2YJ
         joiHFF9stM6OrQxmi13bLv7fP9jFqW1BV7sG2aqkZaC7UM7Gb54IVnfSQCz81BEMZvJa
         gw7g==
X-Gm-Message-State: ACrzQf37J7o8RGIFk0L3yMmso0bNdQEBGKYuW18ZA6XIKWoddrDdE86C
        3r6qOAS3Wo67/97/vnOJFDT654LyS6gQLHlm4M84kQ==
X-Google-Smtp-Source: AMsMyM5KZuDwvE3apQ9pHqcDFjofKL8mxCNQPblHh1p95fGuAklUekavrnU/j/FRFmn51VGhNlUxJuhEsb3RLs6REnw=
X-Received: by 2002:a17:903:11c7:b0:178:afa2:43fd with SMTP id
 q7-20020a17090311c700b00178afa243fdmr475305plh.126.1663691272149; Tue, 20 Sep
 2022 09:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220916131854.687371-1-jsd@semihalf.com> <20220916131854.687371-2-jsd@semihalf.com>
 <YyScSCcXOT9/KD5w@smile.fi.intel.com>
In-Reply-To: <YyScSCcXOT9/KD5w@smile.fi.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Tue, 20 Sep 2022 18:27:41 +0200
Message-ID: <CAOtMz3NY=iGf8yUwv_u1y6ke1taqi1-rcZOSZdj+n8a4+JJ3BQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] i2c: designware: Switch from using MMIO access
 to SMN access
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, wsa@kernel.org,
        rrangel@chromium.org, upstream@semihalf.com,
        mario.limonciello@amd.com
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

Hi Andy,

pon., 19 wrz 2022 o 15:59 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Fri, Sep 16, 2022 at 03:18:53PM +0200, Jan Dabros wrote:
> > Due to a change in silicon compared to Cezanne, in future revisions MSR
> > access can't be used to get the base address of the PSP MMIO region tha=
t
> > contains the PSP mailbox interface.
> >
> > Modify driver to use SMN access also for Cezanne platforms (it is
> > working there) in order to simplify codebase when adding support for ne=
w
> > SoC versions.
> >
> > Export amd_cache_northbridges() which was unexported by
>
> > e1907d3: "x86/amd_nb: Unexport amd_cache_northbridges()"
>
> Please, use standard format of referring to the commits in the history
> (basically the same as for Fixes tags).

Sure.

>
> > since function which registers i2c-designware-platdrv is a
> > subsys_initcall that is executed before fs_initcall (when enumeration o=
f
> > NB descriptors occurs). Thus in order to use SMN accesses it's necessar=
y
> > to explicitly call amd_cache_northrbidges() from within this driver.
>
> Also it doesn't clarify if this commit a full revert of that (rebased for
> new kernel versions) or partial or functional?

This is a partial revert, I will mention this in the commit msg.

Best Regards,
Jan
