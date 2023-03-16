Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507ED6BD80F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCPSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCPSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:18:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF01E193F;
        Thu, 16 Mar 2023 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678990704; x=1710526704;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/GnY+D05AYcUSyIie4JZA4hwK2HevYRArrSO76XL0I4=;
  b=Z+4iaKifcrZ+MOIn73nd8YKnj/Gi1wMdGy2t0bxglkVbFH2VlVTXEVWn
   iaKT9rNm6nO+/l8pB3YGZsxG5mZkG9JNaI9ga/sIDS/pPRXNXI9mPtnYM
   5gdIXAG/UlrEfbU+3Do6b7gakbZnK5ribvDdaM9qpHAV1FAmv+n0reuNH
   vs0sjdxFrRi1YMEKL0ql6dEyjiKiNQ0OTMxfN3tiTWbaqdmGjQVnpqvTK
   tdoVzzzdfJfpTUgRsOr2Qhc4CssDGWxzOxs20/0wqkZhf9RruAP4gDwSy
   o+yV0hCPd2O7jOP4KO+yAkUlJv6yCiUgRPc3tridm2MDlVaVp3q+HVVnF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="336769056"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="336769056"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="803842404"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="803842404"
Received: from mgisomme-mobl1.amr.corp.intel.com ([10.212.42.167])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 11:18:11 -0700
Message-ID: <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Mar 2023 11:18:09 -0700
In-Reply-To: <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
         <20230309040107.534716-2-dzm91@hust.edu.cn>
         <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, 2023-03-16 at 15:25 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 3/9/23 05:01, Dongliang Mu wrote:
> > The previous commit 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix
> > double free reported by Smatch") incorrectly handle the
> > deallocation of
> > res variable. As shown in the comment, intel_vsec_add_aux handles
> > all
> > the deallocation of res and feature_vsec_dev. Therefore, kfree(res)
> > can
> > still cause double free if intel_vsec_add_aux returns error.
> >=20
> > Fix this by adjusting the error handling part in
> > tpmi_create_device,
> > following the function intel_vsec_add_dev.
> >=20
> > Fixes: 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix double free
> > reported by Smatch")
> > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

>=20
> IIRC then after this v2 was posted I still saw some comments on the
> original v1 which was not posted on the list. Without the v1 comments
> being on the list and this archived, I have lost track of what the
> status of these patches is.
>=20
> Srinivas, can you let me know if I should merge these, or if more
> changes are necessary ?
>=20
> From the off-list discussion of v1 I got the impression more changes
> are necessary, but I'm not sure.

I was looking for changes submitted=C2=A0by the following patch
"
[PATCH linux-next v2 3/3] drivers/platform/x86/intel: fix a memory leak
in intel_vsec_add_aux
"

Since I was not copied on this, I was unaware. So I was requesting this
change.

Thanks,
Srinivas

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
> > ---
> > =C2=A0drivers/platform/x86/intel/tpmi.c | 17 ++++-------------
> > =C2=A01 file changed, 4 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/tpmi.c
> > b/drivers/platform/x86/intel/tpmi.c
> > index c999732b0f1e..882fe5e4763f 100644
> > --- a/drivers/platform/x86/intel/tpmi.c
> > +++ b/drivers/platform/x86/intel/tpmi.c
> > @@ -215,8 +215,8 @@ static int tpmi_create_device(struct
> > intel_tpmi_info *tpmi_info,
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0feature_vsec_dev =3D kz=
alloc(sizeof(*feature_vsec_dev),
> > GFP_KERNEL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!feature_vsec_dev) =
{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D -ENOMEM;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto free_res;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kfree(res);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(feature_id_nam=
e, sizeof(feature_id_name), "tpmi-
> > %s", name);
> > @@ -242,17 +242,8 @@ static int tpmi_create_device(struct
> > intel_tpmi_info *tpmi_info,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * feature_vsec_dev mem=
ory is also freed as part of device
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * delete.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D intel_vsec_add_aux(v=
sec_dev->pcidev, &vsec_dev-
> > >auxdev.dev,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_vsec_dev,
> > feature_id_name);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto free_res;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > -
> > -free_res:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(res);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return intel_vsec_add_aux(vs=
ec_dev->pcidev, &vsec_dev-
> > >auxdev.dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_vsec_dev,
> > feature_id_name);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
>=20

