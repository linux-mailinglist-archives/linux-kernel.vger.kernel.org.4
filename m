Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D505A5B857E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiINJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiINJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:50:20 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3E1FCF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:50:17 -0700 (PDT)
Date:   Wed, 14 Sep 2022 09:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663149012; x=1663408212;
        bh=6VovnvAvT7wB2LMpcTIS6rq0tvcrlTsBEIBwvJyaOr0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=sPnuCl9H1XDQAYDW16m7Z6w8txbgbXzwm+GzI9H0R444QpWr5gScwlFtBZ3+8rahu
         4PmyCCH/RJ6fEHcEF3GyUHWTavG3g3pVseOEeUXSL0AP6avrR2+s/QFluYau+iHvDo
         9O1/pEx63zTcEBCKbhEBLQnpjmcRKtkXeKL1oEVi6cwIsuePDqsrAHJINjoy9KYVBx
         6+FGcXlM0JjkXCWEeTSz+qtDIOah+dXI4RTMSgoGmaDlKwPDanOnBr74Xy7IYzPSLU
         S8aK4iHQpww0mxFw2v4kBWhwp2xuA/bt/T77FRyMnlXkNM3Q3ox1h90DBaYtxpsH8f
         Lp/5D9kjr293A==
To:     Mario Limonciello <mario.limonciello@amd.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd: pmc: Add sysfs files for SMU
Message-ID: <-v-ziVgHRq7Du4eop0IF6fTMkTT8XCT7ZbcGnyIIppnBSAgjI1fUCsHCVrW7C3tcvj7_lXHjvAyjHmd8ksObYBoxp5c4A0nlFvOwGpO8Im4=@protonmail.com>
In-Reply-To: <20220913142510.1612-1-mario.limonciello@amd.com>
References: <20220913142510.1612-1-mario.limonciello@amd.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

2022. szeptember 13., kedd 16:25 keltez=C3=A9ssel, Mario Limonciello =C3=
=ADrta:

> The CPU/APU SMU FW version and program is currently discoverable by
> turning on dynamic debugging or examining debugfs for the amdgpu
> driver. To make this more discoverable, create a dedicated sysfs
> file for it that userspace can parse without debugging enabled.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-amd-pmc | 13 ++++++++
>  drivers/platform/x86/amd/pmc.c          | 44 +++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-amd-pmc
>=20
> diff --git a/Documentation/ABI/testing/sysfs-amd-pmc b/Documentation/ABI/=
testing/sysfs-amd-pmc
> new file mode 100644
> index 000000000000..ff627b48c875
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-amd-pmc
> @@ -0,0 +1,13 @@
> +What:=09=09/sys/bus/platform/drivers/amd_pmc/*/smu_fw_version
> +Date:=09=09October 2022
> +Contact:=09Mario Limonciello <mario.limonciello@amd.com>
> +Description:=09Reading this file reports the version of the firmware loa=
ded to
> +=09=09System Management Unit (SMU) contained in AMD CPUs and
> +=09=09APUs.
> +
> +What:=09=09/sys/bus/platform/drivers/amd_pmc/*/smu_program
> +Date:=09=09October 2022
> +Contact:=09Mario Limonciello <mario.limonciello@amd.com>
> +Description:=09Reading this file reports the program corresponding to th=
e SMU
> +=09=09firmware version.  The program field is used to disambiguate two
> +=09=09APU/CPU models that can share the same firmware binary.
> \ No newline at end of file
    ^^^^^^^^^^^^^^^^^^^^^^^^^


> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pm=
c.c
> index 700eb19e8450..4302e7662087 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -455,6 +455,49 @@ static int amd_pmc_get_smu_version(struct amd_pmc_de=
v *dev)
>  =09return 0;
>  }
>=20
> +static ssize_t smu_fw_version_show(struct device *d, struct device_attri=
bute *attr,
> +=09=09=09=09   char *buf)
> +{
> +=09struct amd_pmc_dev *dev =3D dev_get_drvdata(d);
> +
> +=09if (!dev->major) {
> +=09=09int rc =3D amd_pmc_get_smu_version(dev);
> +
> +=09=09if (rc)
> +=09=09=09return rc;
> +=09}
> +=09return sysfs_emit(buf, "%u.%u.%u\n", dev->major, dev->minor, dev->rev=
);
> +}
> +static DEVICE_ATTR_RO(smu_fw_version);
> +
> +static ssize_t smu_program_show(struct device *d, struct device_attribut=
e *attr,
> +=09=09=09=09   char *buf)
> +{
> +=09struct amd_pmc_dev *dev =3D dev_get_drvdata(d);
> +
> +=09if (!dev->major) {
> +=09=09int rc =3D amd_pmc_get_smu_version(dev);
> +
> +=09=09if (rc)
> +=09=09=09return rc;
> +=09}
> +=09return sysfs_emit(buf, "%u\n", dev->smu_program);
> +}
> +static DEVICE_ATTR_RO(smu_program);
> +
> +static struct attribute *pmc_attrs[] =3D {
> +=09&dev_attr_smu_fw_version.attr,
> +=09&dev_attr_smu_program.attr,
> +};

I believe this should be NULL-terminated.


> +static struct attribute_group pmc_attr_group =3D {
> +=09.attrs =3D pmc_attrs,
> +};
> +
> +static const struct attribute_group *pmc_groups[] =3D {
> +=09&pmc_attr_group,
> +=09NULL,
> +};

I think you could use the ATTRIBUTE_GROUPS() macro to generate these two ob=
jects.


> +
>  static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  {
>  =09struct amd_pmc_dev *dev =3D s->private;
> @@ -935,6 +978,7 @@ static struct platform_driver amd_pmc_driver =3D {
>  =09.driver =3D {
>  =09=09.name =3D "amd_pmc",
>  =09=09.acpi_match_table =3D amd_pmc_acpi_ids,
> +=09=09.dev_groups =3D pmc_groups,
>  =09},
>  =09.probe =3D amd_pmc_probe,
>  =09.remove =3D amd_pmc_remove,
> --
> 2.34.1
>=20


Regards,
Barnab=C3=A1s P=C5=91cze
