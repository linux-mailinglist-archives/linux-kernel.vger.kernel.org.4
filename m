Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8A6330E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiKUXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKUXqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA0E0CAE;
        Mon, 21 Nov 2022 15:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669074253; x=1700610253;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xC7h8r9pMHIQvZ0KVo0bKZvTmlDvxidFVqPF/Ks1PH8=;
  b=EUM5zyjsbQ2mHUazVgQmkoO3Ic8LXepuo0AU2YhOpjS3qqrgqe8yCXJ9
   T9/KxQZhjK0Hkn/c5DXoW0p/ZDEHc1VStUbNl84Ch6eUp7v18VvL6OcmK
   FcD7bSzLd4kp5uX6KTFtiWwo3/boJ4RXf11k9tSRbkopMfgztuvIuOzw/
   lkdCiSK1owjxRTteyPtFSstaPgodJYJx32EC3hcGkteb4ZDAS33d6VQYK
   0TbgHEy493QM348NTAHFupMe1KeCuqtMP1HU7BSX3nnF1FLn0fMNWu+Xp
   aR9b5V9SImOIvYr9My3JGPuaIjyNlM43+W8a5r/QSUjshgxTmXXsR6bvK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="294077272"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="294077272"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="730193995"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="730193995"
Received: from han1-mobl4.jf.intel.com (HELO [10.54.74.10]) ([10.54.74.10])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:13 -0800
Message-ID: <1398b5489da6884d86245e4a6442575e85bf2d73.camel@linux.intel.com>
Subject: Re: [PATCH v4] Bluetooth: btintel: Correctly declare all module
 firmware files
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Nov 2022 15:44:05 -0800
In-Reply-To: <20221121145125.1303097-1-dimitri.ledkov@canonical.com>
References: <20221121145125.1303097-1-dimitri.ledkov@canonical.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitri,

On Mon, 2022-11-21 at 14:51 +0000, Dimitri John Ledkov wrote:
> Strictly encode patterns of supported hw_variants of firmware files
> the kernel driver supports requesting. This now includes many missing
> and previously undeclared module firmware files for 0x07, 0x08,
> 0x11-0x14, 0x17-0x1b hw_variants.
>=20
> This especially affects environments that only install firmware files
> declared and referenced by the kernel modules. In such environments,
> only the declared firmware files are copied resulting in most Intel
> Bluetooth devices not working. I.e. host-only dracut-install initrds,
> or Ubuntu Core kernel snaps.
>=20
> BugLink: https://bugs.launchpad.net/bugs/1970819
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
> =C2=A0Changes since v3:
> =C2=A0- Hopefully pacify trailing whitespace from GitLint in this optiona=
l
> =C2=A0=C2=A0 portion of the commit.
>=20
> =C2=A0Changes since v2:
> =C2=A0- encode patterns for 0x17 0x18 0x19 0x1b hw_variants
> =C2=A0- rebase on top of latest rc tag
>=20
> =C2=A0Changes since v1:
> =C2=A0- encode strict patterns of supported firmware files for each of th=
e
> =C2=A0=C2=A0 supported hw_variant generations.
>=20
> =C2=A0drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
> =C2=A01 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a657e9a3e96a..55efc4a067db 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.or=
g>");
> =C2=A0MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSI=
ON);
> =C2=A0MODULE_VERSION(VERSION);
> =C2=A0MODULE_LICENSE("GPL");
> -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> +/* hw_variant 0x07 0x08 */
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
> +/* hw_variant 0x0b 0x0c */
> +MODULE_FIRMWARE("intel/ibt-11-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-12-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-11-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-12-*.ddc");
> +/* hw_variant 0x11 0x12 0x13 0x14 */
> +MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");

There are firmware files for hw_variant 0x11 and 0x12 in an old format like
ibt-17-*.sfi, ibt-17-*.ddc, ibt-18-*.sfi, and ibt-18-*.ddc.

> +/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
> +MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
> +MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");

I believe these are under intel/ folder.


Regards,
Tedd Ho-Jeong An

