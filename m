Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813B173E56E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFZQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFZQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:42:44 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCD83
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:42:43 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1aa161c3796so3512224fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687797762; x=1690389762;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SwX6cfVqw98eMyok7nrC6AFbCPNpuOo35y0pnv1Y5UQ=;
        b=DvEsvrXUxui3HZWIc/B6vrb+aJQ+mphmN+1F8MTV0qKkpx2u1p0iKoFS05AmlqmJ0S
         V9ozOGkIHsDyg+qB8rkUqRm+2RRfPWE9KI6cuDXK6O7cJuJn7kLLw7O6vkq58RNQ5/X7
         lBlkSMvvOr60mZpjgWzHHH6UTgSTtPlGnluBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797762; x=1690389762;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwX6cfVqw98eMyok7nrC6AFbCPNpuOo35y0pnv1Y5UQ=;
        b=VKXsY23N4AdWb3ZHKeRSKe+5CVFcJ9UB3BaEZyg7tJhEpxCrQvVKfhRH609Bj2MVQh
         byxXe6YupN4oPT4YABlPm8wfsHVSm1/N92b9F0uL6Fj1yqeCACUmlevbDrn+HTRMVGCt
         QcIte9lFYEsRePprlfvjtA66Y099vYBvnfdBsqq7Os0Jrdn3UvjmLDBXt10RtYmT60B3
         bV8+bXvozb6T7ygepiqW8aP+tarRs25AWkPyhLEv2NPtL6p4O0EyjkbQ9Qfrb6Uw+unq
         2CYi6QkcV12bqFn3Asi6spcKlNANzSH7WTXPogbkCLihfQMyeCV7HW3yqjaxjbUtNi6G
         qX6A==
X-Gm-Message-State: AC+VfDx5QK8GXuYzbPYDLZyAIlPkKuS1QSf7edWOcNEgQHoezCWYq+Cl
        OhMjWva7prmvWrqRAlYjhT3a4Q==
X-Google-Smtp-Source: ACHHUZ6ryBVYZ475S6GBd7/gw3WoZ/8NKnrQ7gQEEdXwHEYeCp5+Im/cmq+hiNQnntW/5qFmgR81Ow==
X-Received: by 2002:a05:6808:128d:b0:3a0:30c4:5d45 with SMTP id a13-20020a056808128d00b003a030c45d45mr28450600oiw.33.1687797762449;
        Mon, 26 Jun 2023 09:42:42 -0700 (PDT)
Received: from [10.136.64.163] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id g6-20020a635206000000b0054fd46531a1sm4319710pgb.5.2023.06.26.09.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:42:41 -0700 (PDT)
Message-ID: <b68ad6c4-f5e6-9bb7-0ac8-2cd08ce04c7a@broadcom.com>
Date:   Mon, 26 Jun 2023 09:42:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue
To:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>
Cc:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <TYCP286MB1188708B1CE64D95FBACF9E78A20A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
From:   Ray Jui <ray.jui@broadcom.com>
In-Reply-To: <TYCP286MB1188708B1CE64D95FBACF9E78A20A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001bbd5d05ff0b0a6d"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001bbd5d05ff0b0a6d
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chengfeng,

On 6/24/2023 12:36 PM, YE Chengfeng wrote:
> iproc_i2c_rd_reg and iproc_i2c_wr_reg are called from both
> interrupt context (e.g. bcm_iproc_i2c_isr) and process context
> (e.g. bcm_iproc_i2c_suspend). Therefore, interrupts should be
> disabled to avoid potential deadlock. To prevent this deadlock,
> use spin_lock_irqsave.
> 
> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 85d8a6b04885..d02245e4db8c 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -233,13 +233,14 @@ static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
>                                    u32 offset)
>  {
>         u32 val;
> +       unsigned long flags;
> 
>         if (iproc_i2c->idm_base) {
> -               spin_lock(&iproc_i2c->idm_lock);
> +               spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
>                 writel(iproc_i2c->ape_addr_mask,
>                        iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
>                 val = readl(iproc_i2c->base + offset);
> -               spin_unlock(&iproc_i2c->idm_lock);
> +               spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
>         } else {
>                 val = readl(iproc_i2c->base + offset);
>         }
> @@ -250,12 +251,13 @@ static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
>                                     u32 offset, u32 val)
>  {
> +       unsigned long flags;
>         if (iproc_i2c->idm_base) {
> -               spin_lock(&iproc_i2c->idm_lock);
> +               spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
>                 writel(iproc_i2c->ape_addr_mask,
>                        iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
>                 writel(val, iproc_i2c->base + offset);
> -               spin_unlock(&iproc_i2c->idm_lock);
> +               spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
>         } else {
>                 writel(val, iproc_i2c->base + offset);
>         }
> -- 
> 2.17.1

This fix looks good to me. Thanks. Just curious, did you actually see a
race condition issue as a result of this, or the fix is done completely
based on the analysis of the code?

Acked-by: Ray Jui <ray.jui@broadcom.com>


--0000000000001bbd5d05ff0b0a6d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YVhHgdTTB3aAzFyz4UFRLwxCzIG7d7GIiB9MoLImssS08R5WQ5EJCd1fAF6iefLupAn/plPmn2w0
GF8bLF/FhwOn8jObLW5pQiKhjQSv3QIDAQABo4IB1TCCAdEwDgYDVR0PAQH/BAQDAgWgMIGjBggr
BgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9j
YWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8v
b2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBE
MEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20v
cmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2Jh
bHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAfBgNVHREEGDAWgRRyYXku
anVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIScG7uNJuCYBQieQC+eonQS9tdkwDQYJKoZIhvcNAQEL
BQADggEBAGLwq/sDtwLmkAa5/UpIG4o5HA9EH7SaYi05EUlzrDdIeZsJnXDkxmG9144wNZBbndHx
nKXRnpJjCX4jhZeNQFyY4m5c9c8bMytO4zb8XUJIxCjqkhtukJtqHieEogwGsmZlpOxt6Ucc2JXg
6oTTbyITD4Bvn7cFb7EI2FBcT7K8bf8AvwtNLl/dKYtUA/nEvVhjqp0wsDL3t//Q3GTwGWZB41gf
LC04V6gD9TVFl7i/N48Gu8PzTt4Kt0SZvBr7kQ9PKi7DVyXe23Ou89QVflaja3bPjt2UZCyq0JxJ
Nu5SjFDWjKlBCzbLDGkCBlM4DpjAb0y4MyKOsiVv7vIxNlYxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwcAgHcg4j27cIp1UUwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEILZ//8V+BKO9hr+E/jLUwpCogskHSsVX4fr13eNRRUq5MBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYyNjE2NDI0MlowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBwRqUrN7a+m1XtG4V3WDgT+gRUq4Fv62kLL0EDVn3vBOLH9t4OmX/5EZERD/DrnS4ZSJ+p
G2gWKZsX+I017SsRGREJQEn5cIPtYdYbrVu7HvJxs9e2a43URmDCzTjRWqJ2pZiQ/QXGWrLY80T6
LGDxotgDTjjsYtcyX8DAv+KCapgkTBTHv/q3zhUV9Cr9mYX98atCm6IblVcrKu0y2zYG6+6ds2Hg
yWfi/P903+0SPAIXh9ynLs6DrRw26yUQuW8Ei5oLUDn2JA53dDJh//fExEBus8MYQG/vPY33OtqU
uX1gxml5Bdnyf39I+1zvS84iDabSl5emZcqg/UHWW7lf
--0000000000001bbd5d05ff0b0a6d--
