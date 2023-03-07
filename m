Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADD6AE773
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCGQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCGQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:57:44 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5BF96C1C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:53:52 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a65so4670308qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678208032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLjzoBnlY+N8c+BPItOeN27vRL9Wum4fM9tcJ2O3obw=;
        b=ArKcoU50WA1bub0Rjl6km4fU1VFTN25LL5jAnNotJTiFTjblb7GMuzTfMzSRu0Baid
         ShEcq6Zj/nVLPfk/WbSVCjTpfF+WAA+FJnJRimjo9PxRfLbx0qh+SQivbHikPlM0rhJW
         XDYWVDgEePnKfqjl8oYqdwO5XYvRVVG+egUYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678208032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLjzoBnlY+N8c+BPItOeN27vRL9Wum4fM9tcJ2O3obw=;
        b=kW/HFbNVQwgSfraLpi2kowpprcNXsUavHaiIilL7zCRiTl1KYN8yn5zwpmZHC4ZvwD
         c/UZkFosBz7VOOZevxejGeljGrsxqpK5a219Y2+f4+zC4lE1Mz+vaiPZTi73KTQCTsLj
         HoE0DzNQ832wCmkGwYB02DVyDyyqcUqUueN77u+DUfbT8VGTqR2ld8K8swptYBS6KNSB
         /skUtoQrIHwmgLiA4yIx2c8km8DnPcG6fjqj6ygU0VGoHXyc00P9rhZEx3Gku2HZ7J1l
         SEvtWOpLXVuWtxQcnFgEUNosW8UUEDMT1ZXpoS1a/0RMlWR22RYimLShdsFTI0nTUGm7
         HLgQ==
X-Gm-Message-State: AO0yUKWJ9koNjTvEWoTqduiWkC2L64z8lERLYjZ3PBG1cdHK6IRMa5W+
        5avXPoZG52JTX8Fcqzgwep1lONLPF6Qv2K24dyWUNCjArFsLjEolNMToH3Iq9+gmAuAcXA5yMyY
        ORVdjkvPx1clxCZsJxqflxKG2L9Ey+A==
X-Google-Smtp-Source: AK7set+TFuAgbBwvn7lhclTzjFDWa+c6N6vB9e/bBA8YxPohfMd/oXTyxiKUntM12zqJ6O/HUt60F0QytzXVFrpx69A=
X-Received: by 2002:a37:6514:0:b0:742:9d0f:775f with SMTP id
 z20-20020a376514000000b007429d0f775fmr3231324qkb.15.1678208031823; Tue, 07
 Mar 2023 08:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20230225100135.2109330-1-haowenchao2@huawei.com>
In-Reply-To: <20230225100135.2109330-1-haowenchao2@huawei.com>
From:   Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date:   Tue, 7 Mar 2023 09:53:35 -0700
Message-ID: <CAFdVvOwxxvMGNTS9KQ-N-Q_Xo3+qKA64ok=2sv-FYmnerzwfGQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: mpt3sas: fix NULL pointer access in mpt3sas_transport_port_add()
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009e6d6505f652419a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009e6d6505f652419a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2023 at 3:02=E2=80=AFAM Wenchao Hao <haowenchao2@huawei.com=
> wrote:
>
> port is allocated by sas_port_alloc_num() and rphy is allocated by
> sas_end_device_alloc() or sas_expander_alloc() which may return NULL,
> so we need to check the rphy to avoid possible NULL pointer access.
>
> If sas_rphy_add() called with failure rphy is set to NULL, we would
> access the rphy in next lines which would also result NULL pointer
> access.
>
> Fix commit 78316e9dfc24 ("scsi: mpt3sas: Fix possible resource leaks
> in mpt3sas_transport_port_add()")
>
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Acked-by: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3=
sas/mpt3sas_transport.c
> index e5ecd6ada6cd..e8a4750f6ec4 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -785,7 +785,7 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *io=
c, u16 handle,
>                 goto out_fail;
>         }
>         port =3D sas_port_alloc_num(sas_node->parent_dev);
> -       if ((sas_port_add(port))) {
> +       if (!port || (sas_port_add(port))) {
>                 ioc_err(ioc, "failure at %s:%d/%s()!\n",
>                         __FILE__, __LINE__, __func__);
>                 goto out_fail;
> @@ -824,6 +824,12 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *i=
oc, u16 handle,
>                             mpt3sas_port->remote_identify.sas_address;
>         }
>
> +       if (!rphy) {
> +               ioc_err(ioc, "failure at %s:%d/%s()!\n",
> +                       __FILE__, __LINE__, __func__);
> +               goto out_delete_port;
> +       }
> +
>         rphy->identify =3D mpt3sas_port->remote_identify;
>
>         if ((sas_rphy_add(rphy))) {
> @@ -831,6 +837,7 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *io=
c, u16 handle,
>                         __FILE__, __LINE__, __func__);
>                 sas_rphy_free(rphy);
>                 rphy =3D NULL;
> +               goto out_delete_port;
>         }
>
>         if (mpt3sas_port->remote_identify.device_type =3D=3D SAS_END_DEVI=
CE) {
> @@ -857,7 +864,10 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *i=
oc, u16 handle,
>                     rphy_to_expander_device(rphy), hba_port->port_id);
>         return mpt3sas_port;
>
> - out_fail:
> +out_delete_port:
> +       sas_port_delete(port);
> +
> +out_fail:
>         list_for_each_entry_safe(mpt3sas_phy, next, &mpt3sas_port->phy_li=
st,
>             port_siblings)
>                 list_del(&mpt3sas_phy->port_siblings);
> --
> 2.32.0
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000009e6d6505f652419a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
v82E+npLwqC8bSHh1m6BJewfpawx72uKM9aFs6SVpLPtN6a5369OCwVeEwkk2FeFU9tZXWBnI4Wu
d1Q4a3vhOColD6PdTWv74Ez2I3ahCkmpeEQ1YMt61TUH3W8NUJJeYN2xkR6OGsA1AgMBAAGjggHc
MIIB2DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRw
Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJz
b25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRC
MEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3JsMCYGA1UdEQQfMB2BG3NhdGh5YS5wcmFrYXNoQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
VyBc/F5XGkYNCP9Rb96mru8lU4AwDQYJKoZIhvcNAQELBQADggEBACiysbqj0ggjcc9uzOpBkt1Q
nGtvHhd9pbNmshJRUoNL11pQEzupSsUkDoAa6hPrOaJVobIO+yC84D4GXQc13Jk0QZQhRJJRYLwk
vdq704JPh4ULIwofTWqwsiZ1OvINzX9h9KEw/+h+Mc3YUCO7tvKBGLJTUaUhrjxyjLQdEK1Xp/8B
kYd5quZssxYPJ3nl37Moy/U9ZM2F0Ivv4U3wyP5y5cdmBUBAGOd94rH60fVDVogEo5F9gXrZhT/4
jKzCG3LclOOzLinCkK2J5GYngIUHSmnqk909QPG6jkx5RJWwkpTzm+AAVbJ9a+1F/8iR3FiDddEK
8wQJuWG84jqd/9wxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgx2rp2oPFt1hdtt8l8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICsJaJwu
hlRGgy1FCrG3ScvNveT29J6XtA1uwTQ4oqe1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDMwNzE2NTM1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC1+aqsFM8MBfmaIbHo4Uj10MNB
6aEadZzjWPWgKImMM3szKWfGimtfYSyWa+qoYShyVT0/encTS5fM9jSre9eOQzx64ZZWPIyZubTT
vU9g21vTlROiOSLupaiJVmzLCtHu4O2wQFQ2AE/mZPZExzI7/q+toAQYGeNeGn/axt0FrpE6r5Jh
FGAE4iKzHLJ0VPcKG2m1jFp2PrtAOm/Y5m2JGoL3BaSMcME3m0TBNzZ44jd7Xqg3r5q4EqaCRU6u
a9k/veAIIzup5Ju8nRbKHrGreE0pg95unmM5QunP0cstFUR856dPJl4DPb0ptLiqwxTzwwRIcpYG
jayN2myoTeyW
--0000000000009e6d6505f652419a--
