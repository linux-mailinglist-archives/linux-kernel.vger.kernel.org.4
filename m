Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1461142A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJ1OMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJ1OMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:12:20 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883791C2F3C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666966321; bh=PXfpLqpOYBcI1Lo76bMYPULHjjg8Sa7dzXoCXqonkdg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=kRvHprBywqaFwKXnjXwVJq7zf6lK3X4YN8i7VxJl1nGiUYyyQchmQOY+7KKiuC35D
         RBDx5w0i/BZZjX33+o8+Hc3DrhxxAyT6+RZTo4ln5ZoP+U6FHvjapHWzRXSIHKjwha
         /Co8vu/oO3rpNRCspo09MwDwgB0p5WOc13ORppZs=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Fri, 28 Oct 2022 16:12:01 +0200 (CEST)
X-EA-Auth: 2brZ/kS3MaIQqO2fgn9LVp7rMacZtiDcVAzdOm91Qxc5brw+pTbx/0tQ4sMWLib0wTsx3TtE5xIll/QwALGEO0j9yO1eRG0y
Date:   Fri, 28 Oct 2022 19:41:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Use flexible-array for one length
 array member
Message-ID: <Y1vjKtM9druO2bSN@ubunlion>
References: <Y1vRivFfRD6VoBt/@ubunlion>
 <642519a2-664d-d837-983a-1d5bbc72a25e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642519a2-664d-d837-983a-1d5bbc72a25e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:03:25PM +0300, Pavel Skripkin wrote:
> Hi Deepak R,
>
> Deepak R Varma <drv@mailo.com> says:
> > Flexible-array member should be used instead of one or zero member to
> > meet the need for having a dynamically sized trailing elements in a
> > structure. Refer to links [1] and [2] for detailed guidance on this
> > suggestion.
> >
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> >
> > Issue identified using coccicheck.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >   drivers/staging/r8188eu/include/odm.h         | 2 +-
> >   drivers/staging/r8188eu/include/wlan_bssdef.h | 6 +++---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> > index 89b01dd614ba..e2a9de5b9323 100644
> > --- a/drivers/staging/r8188eu/include/odm.h
> > +++ b/drivers/staging/r8188eu/include/odm.h
> > @@ -166,7 +166,7 @@ struct odm_ra_info {
> >
> >   struct ijk_matrix_regs_set {
> >   	bool	bIQKDone;
> > -	s32	Value[1][IQK_Matrix_REG_NUM];
> > +	s32	Value[][IQK_Matrix_REG_NUM];
> >   };
> >
>
> you are changing the actual size of the struct. Wondering if you have tested
> this patch somehow

Hello Pavel,
Thank you for reviewing the patch. I build the module post making the changes an
ensured that the build is successful. However, I am not sure how to check the
changes I am proposing. Could you please direct me to some information on how to
test patches? Is there some documentation generic/driver-specific that I can
refer to?

>
> >   struct odm_rf_cal {
> > diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
> > index 831c465df500..33177de194eb 100644
> > --- a/drivers/staging/r8188eu/include/wlan_bssdef.h
> > +++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
> > @@ -179,7 +179,7 @@ struct ndis_802_11_status_ind {
> >
> >   struct ndis_802_11_auth_evt {
> >   	struct ndis_802_11_status_ind       Status;
> > -	struct ndis_802_11_auth_req  Request[1];
> > +	struct ndis_802_11_auth_req  Request[];
> >   };
> >
>
> this structure seems to be unused. Better to remove it instead of
> maintaining the old code

Sounds good. I agree and will do as suggested.

>
> >   struct ndis_802_11_test {
> > @@ -291,7 +291,7 @@ struct pmkid_candidate {
> >   struct ndis_802_11_pmkid_list {
> >   	u32 Version;       /*  Version of the structure */
> >   	u32 NumCandidates; /*  No. of pmkid candidates */
> > -	struct pmkid_candidate CandidateList[1];
> > +	struct pmkid_candidate CandidateList[];
> >   };
>
> this one as well

Yes, same here.

>
> >
> >   struct ndis_802_11_auth_encrypt {
> > @@ -304,7 +304,7 @@ struct ndis_802_11_cap {
> >   	u32  Version;
> >   	u32  NoOfPMKIDs;
> >   	u32  NoOfAuthEncryptPairsSupported;
> > -	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[1];
> > +	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[];
> >   };
> >
> >   u8 key_2char2num(u8 hch, u8 lch);
> > --
> > 2.34.1
> >
>
> and this one as well

Yes, will do.

Thank you again for your feedback and suggestions.

./drv

>
> >
> >
>
>
>
>
>
> With regards,
> Pavel Skripkin
>


