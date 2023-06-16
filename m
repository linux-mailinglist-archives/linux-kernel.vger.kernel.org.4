Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0950733834
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjFPSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjFPSfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:35:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A41FD5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:35:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8f3786f20so9113625e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686940529; x=1689532529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sCwJPBzwjv9cZEvytoy4po7a1xq6KPzk7d1jdAQM6B0=;
        b=UC1NpVP168hMuCX4dpn9zz3jVofBz+4vbwm21l/AlZ+5VQfwMn6i1vJq48SU8Fc2ev
         PmBCNWFOfEB2Z3JjVXGzH3+SeGgQwZxe7nNeukZeBla/uVJe30MTZbAcBx3UcGumxf7O
         WI2YmzCSzOHJ+vg4/bY2TT1nk7iQLeKxYapk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686940529; x=1689532529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCwJPBzwjv9cZEvytoy4po7a1xq6KPzk7d1jdAQM6B0=;
        b=D2ofJB4uxzEKDFMO1/8c5OoYc/7/sJ1xuSyK7ko4EznnCyfFX1HXJgtOeosZKKVIhb
         TJ9WM/uQos5ZhC0eSj66M7Vr/V97sHdiYIzs10KEdEAf8tQxJh4wih5mTuuRDoI5guFu
         Cv7WkF5pH95dHQP1z2DcQBPAsB5rFURwBXSdLGwk9amDvqIjcPUSIJ0YQ9iRiW4iteXx
         X1icvU5zV492XO0EuFcdXnya0sIBn0tpJJwP84voHzYFSEdQ2yLrTB0boHj75++f7muT
         QjP4UBTTQnfDil9FqhbijyZsHgw2QVUv/TJbzXEEvumdS4ThZX2s2iTQNw3nI2g32udM
         X7Qw==
X-Gm-Message-State: AC+VfDzuh7qmt9pDRsbZhxAA4bi0wmb5iYAHp/EgfFVCvQW0mQdAQU0D
        i5Ega/007Mc5m9NXTDMiFqlV14pVD9C247B/c+JY3YjO1PklOPEdOyMLtlD4KQ1YrqCT2bZaIy1
        gApHhVgYf70iHe18Hp5oH1qXcAjsl344=
X-Google-Smtp-Source: ACHHUZ6fqIRR/t2BcANUMmW18AYEJelrSh1STgaFWR7kej7a/jSqZxCZt1lj0utR5sVBsC8cLF2q8dLNHnW4ovLB7nw=
X-Received: by 2002:a7b:c4d4:0:b0:3f6:692:5607 with SMTP id
 g20-20020a7bc4d4000000b003f606925607mr2466878wmk.40.1686940529279; Fri, 16
 Jun 2023 11:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230616090705.2623408-1-arnd@kernel.org>
In-Reply-To: <20230616090705.2623408-1-arnd@kernel.org>
From:   Justin Tee <justin.tee@broadcom.com>
Date:   Fri, 16 Jun 2023 11:35:17 -0700
Message-ID: <CAAmqgVP96Rk4YYGixBqE0AyKt=uNJwCds_chnLAC1K8e4m00hQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: fix lpfc_name struct packing
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000008cec005fe437327"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000008cec005fe437327
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Thanks looks good.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>


On Fri, Jun 16, 2023 at 2:07=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out that the lpfc_name structure has an 8-byte alignement re=
quirement
> on most architectures, but is embedded in a number of other structures th=
at are
> forced to be only 1-byte aligned:
>
> drivers/scsi/lpfc/lpfc_hw.h:1516:30: error: field pe within 'struct lpfc_=
fdmi_reg_port_list' is less aligned than 'struct lpfc_fdmi_port_entry' and =
is usually due to 'struct lpfc_fdmi_reg_port_list' being packed, which can =
lead to unaligned accesses [-Werror,-Wunaligned-access]
>         struct lpfc_fdmi_port_entry pe;
> drivers/scsi/lpfc/lpfc_hw.h:850:19: error: field portName within 'struct =
_ADISC' is less aligned than 'struct lpfc_name' and is usually due to 'stru=
ct _ADISC' being packed, which can lead to unaligned accesses [-Werror,-Wun=
aligned-access]
> drivers/scsi/lpfc/lpfc_hw.h:851:19: error: field nodeName within 'struct =
_ADISC' is less aligned than 'struct lpfc_name' and is usually due to 'stru=
ct _ADISC' being packed, which can lead to unaligned accesses [-Werror,-Wun=
aligned-access]
> drivers/scsi/lpfc/lpfc_hw.h:922:19: error: field portName within 'struct =
_RNID' is less aligned than 'struct lpfc_name' and is usually due to 'struc=
t _RNID' being packed, which can lead to unaligned accesses [-Werror,-Wunal=
igned-access]
> drivers/scsi/lpfc/lpfc_hw.h:923:19: error: field nodeName within 'struct =
_RNID' is less aligned than 'struct lpfc_name' and is usually due to 'struc=
t _RNID' being packed, which can lead to unaligned accesses [-Werror,-Wunal=
igned-access]
>
> From the git history, I can see that all the __packed annotations were do=
ne
> specifically to avoid introducing implicit padding around the lpfc_name
> instances, though this was probably the wrong approach.
>
> To improve this, only annotate the one uint64_t field inside of lpfc_name
> as packed, with an explicit 4-byte alignment, as is the default already o=
n
> the 32-bit x86 ABI but not on most others. With this, the other __packed
> annotations can be removed again, as this avoids the incorrect padding.
>
> Two other structures change their layout as a result of this change:
>
> - struct _LOGO never gained a __packed annotation even though it has the
>   same alignment problem as the others but is not used anywhere in the
>   driver today.
>
> - struct serv_param similarly has this issue, and it is used, my guess
>   is that this is only an internal structure rather than part of a binary
>   interface, so the padding has no negative effect here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/scsi/lpfc/lpfc_hw.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
> index 663755842e4a4..aaea3e31944d0 100644
> --- a/drivers/scsi/lpfc/lpfc_hw.h
> +++ b/drivers/scsi/lpfc/lpfc_hw.h
> @@ -365,7 +365,7 @@ struct lpfc_name {
>                         uint8_t IEEE[6];        /* FC IEEE address */
>                 } s;
>                 uint8_t wwn[8];
> -               uint64_t name;
> +               uint64_t name __packed __aligned(4);
>         } u;
>  };
>
> @@ -850,7 +850,7 @@ typedef struct _ADISC {             /* Structure is i=
n Big Endian format */
>         struct lpfc_name portName;
>         struct lpfc_name nodeName;
>         uint32_t DID;
> -} __packed ADISC;
> +} ADISC;
>
>  typedef struct _FARP {         /* Structure is in Big Endian format */
>         uint32_t Mflags:8;
> @@ -880,7 +880,7 @@ typedef struct _FAN {               /* Structure is i=
n Big Endian format */
>         uint32_t Fdid;
>         struct lpfc_name FportName;
>         struct lpfc_name FnodeName;
> -} __packed FAN;
> +} FAN;
>
>  typedef struct _SCR {          /* Structure is in Big Endian format */
>         uint8_t resvd1;
> @@ -924,7 +924,7 @@ typedef struct _RNID {              /* Structure is i=
n Big Endian format */
>         union {
>                 RNID_TOP_DISC topologyDisc;     /* topology disc (0xdf) *=
/
>         } un;
> -} __packed RNID;
> +} RNID;
>
>  struct RLS {                   /* Structure is in Big Endian format */
>         uint32_t rls;
> @@ -1514,7 +1514,7 @@ struct lpfc_fdmi_hba_ident {
>  struct lpfc_fdmi_reg_port_list {
>         __be32 EntryCnt;
>         struct lpfc_fdmi_port_entry pe;
> -} __packed;
> +};
>
>  /*
>   * Register HBA(RHBA)
> --
> 2.39.2
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

--00000000000008cec005fe437327
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
QsyUohclvlxgt5d/MsBG6WZxZ+uppzNvjEk/wUu+6JQNUVEMviA6eBCCi+4ShjZUbGPES11h5lw/
wuyQZDIjy+1hGPtLHBXI/QQEbU3OVdTRn+aEMwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdqdXN0aW4udGVlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUlHfvnuNaLp52RO2Y2En9J+7MKI4wDQYJ
KoZIhvcNAQELBQADggEBAGaBsEmLZwejb3YsmigadLZGto3hJ7Erq2YZLhL7Pgtxft1/j4JNLsRN
t3ZJIW2Xzfbj0p328xRekSP1gjZ9Szre0fxEFXH1sS1a7WP9E0fHxVW07xVsxGxo5opAh5Gf/bQH
S4x9pCO48FJI310L1RGQiqFKY/OECnXO821y8MAyObbGo9HNHP4Sk6F5J1v2qJzbLtMfj8ybbTGe
SidstRgjOIqMldZs2Koio14QFE7hJY+8KRiKfq+eb1EwQTMzBxZsMOL5vUSZjYg2+Fqwyr6YYp0w
Lsq/wH9o18xSvL/FikpG4JRxiT20RdM6DQrk9lv8ijASZCuN3JR61WUNz2AxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMd6BsMSBDsagVFtYwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILbhSstiH2XA4Umous0zhIM7W08svopCZu7mH4Il
QNXWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYxNjE4MzUy
OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAeEXJB8FrCtTnCth9eZkc2yuCvCtEGWQDowpjR2FuSv6w3/HE8ArQJoNTK
mKvBtIR17s7rbyX6ZiN4pnbmy7wUDpFCFeulsVrEquo3FUP4MXpwVgs+W/rPPrY9nY5Zf5o2gEn1
Ia+9oaymenMXaV32GTdyBa0dpTtioSRJMcqsp2geP/0bNrNlNYMfB/tD0RlOkudCKVjlycvC45+r
cyv/nT4d1OtY0GZynxVVA2rhwvqLdGKphD8T0Bhrn2w63mIUAaMomx3zWJUaTGsxIcKyAsrzcawC
POn18n+/1McYU6cbYjOdWqDMmT6FqPrkRlT5sBxXMgBbRQUVhN9p/2ho
--00000000000008cec005fe437327--
