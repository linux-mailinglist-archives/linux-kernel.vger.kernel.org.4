Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739226DD2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDKGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDKGeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:34:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414259D;
        Mon, 10 Apr 2023 23:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0877621DE;
        Tue, 11 Apr 2023 06:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ADFC433D2;
        Tue, 11 Apr 2023 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681194851;
        bh=x+oH/HMKu73BCpFd8IM0DhA30uUo8CLngL7hAosyFdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlONgH5GrXXlf5h6VLeHlLslNecKJZXb24RI+5PjWyd8gctDAHUuci4CEziLuXGtq
         ewaqggQL3HcYvIxtsGPMLFguVDX4T6QoYzWaySXUAFwW6oGUV4NpGCU5wDooAyoTpZ
         V6UB4TZttKhqX7K1BUZ8K+mivIMIoQO9yaYvO4Rk=
Date:   Tue, 11 Apr 2023 08:34:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Message-ID: <2023041136-donator-faceplate-5f91@gregkh>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 04:32:49PM -0700, John Moon wrote:
> > > According to this tool, it looks like we broke a lot of UAPI
> > > headers in the previous MW (between v6.2 and v6.3-rc1).
> > 
> > That's not ok, and needs to be fixed, otherwise this is useless as no
> > one can rely on it at all.
> > 
> 
> Right, there are several classes of false positives that we've documented
> and when examining thousands of commits at time, it'll flag many things.
> 
> For some comparison, if you run checkpatch on the same changeset
> (v6.2..v6.3-rc1), you get 995 errors and 7,313 warnings. Still, checkpatch
> is helpful for spot-checks.

checkpatch.pl does not matter, it is a "hint", and many patches
explicitly ignore it (think about patches in the staging tree, you could
fix up one checkpatch issue for a line, but ignore another one as you
are not supposed to mix them up.)

Also for some subsystems, checkpatch does not matter because their
codebase is old and follows different rules.  And in some places,
checkpatch is just wrong, because it's a perl script and can not really
parse code.

So NEVER use that as a comparison to the user/kernel abi please.  It's a
false comparison.

> "./scripts/check-uapi.sh -b v6.3-rc1 -p v6.2" flags 36 out of the 911 files
> checked. Of those 36, 19 fell into the currently documented false positive
> categories:
> 
> Enum expansion: 17
> Expanding into padded/reserved fields: 2
> 
> Beyond those, the tool appears to be flagging legitimate breakages.
> 
> Some fit into the definition of "intentional breakages" where support is
> being dropped or something is being refactored:
> 
>  File removals:
>    - include/uapi/drm/i810_drm.h
>    - include/uapi/drm/mga_drm.h
>    - include/uapi/drm/r128_drm.h
>    - include/uapi/drm/savage_drm.h
>    - include/uapi/drm/sis_drm.h
>    - include/uapi/drm/via_drm.h
>    - include/uapi/linux/meye.h
> 
>  File moves:
>    - include/uapi/misc/habanalabs.h
> 
>  Removal of struct:
>    - include/uapi/linux/uuid.h (5e6a51787fef)
>      - include/uapi/linux/mei.h (failed due to uuid.h)
>      - include/uapi/linux/ublk_cmd.h (failed due to uuid.h)
> 
> Others do not seem to be intentional:
> 
>  Addition/use of flex arrays:
>    - include/uapi/linux/rseq.h (f7b01bb0b57f)
>    - include/uapi/scsi/scsi_bsg_mpi3mr.h (c6f2e6b6eaaf)

That is not a breakage, that's a tool problem.

>  Type change:
>    - include/uapi/scsi/scsi_bsg_ufs.h (3f5145a615238)

Again, not a real breakage, size is still the same.

>  Additions into existing struct:
>    - include/uapi/drm/amdgpu_drm.h (b299221faf9b)
>    - include/uapi/linux/perf_event.h (09519ec3b19e)
>    - include/uapi/linux/virtio_blk.h (95bfec41bd3d)

Adding data to the end of a structure is a well-known way to extend the
api, in SOME instances if it is used properly.

So again, not a break.

> Is there something I'm missing that makes these changes false positives? If
> so, I'd be happy to add on to the documentation and work towards a way to
> filter them out.
> 
> In the mean time, we will start a thread on the libabigail mailing list to
> see if there's a way to add flags such as --ignore-enum-expansion,
> --ignore-expansion-into-reserved-fields, etc. Enum expansion seems to be
> making up the largest portion of false positives, so would be the best thing
> to filter out.

Increasing enums is in no way an abi break unless the size of the
structure changes.

Using reserved fields too is not a breakage.

So yes, it looks like the tooling needs some work in order for us to be
able to use this properly, digging through false positives like this is
going to make it not used at all.

thanks,

greg k-h
