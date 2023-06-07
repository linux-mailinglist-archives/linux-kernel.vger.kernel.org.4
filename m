Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD937268E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjFGSfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjFGSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:35:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52C1FF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:35:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b00ecabdf2so71286045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686162920; x=1688754920;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuCV3zRuP5lSuwMqB79xRHC2efPZkLuj33r30ZYj5pE=;
        b=JIqWcO/Z8Tex+hA53tEtR8GSa3td8+ugMwb04wgGkm9QKomEzGbi9Nh9ViHRaS/YuW
         lsqdqrEZRVxhf0ml2/YhHBS2jklt++0NNCjXJRkbQwcxr3EI23hbUO/uxn8uNcBLsdHa
         ntNeSt1Fz1/nyMVXtGuPxjTK1lE1HIrSy+JgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162920; x=1688754920;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuCV3zRuP5lSuwMqB79xRHC2efPZkLuj33r30ZYj5pE=;
        b=ITBpDYurwoai4U/4IVc1/yO/Z5QgI+3pyg8aE0aGzsZMXPbW4s5mo9I71j9Lj8jIpq
         xKymmaLsvm/kOXNvOzphUr81JUI1PhhN5kB2oRHvq6Wkd94nkhMmbND6b+lhrYgW8MSC
         /mf/e3r3+E2akKCEsUlMUctYQrhIS1urJSbX5h8l6U7PRipZ2vDJcq4B/cDuBtpagDdj
         9R+ZFMg8j7xNOPfTDQD1z/3FdbUGb7mnEBBki9/q0G9eiD+Vglwm29tIeHkwl3GegbJh
         GWhFo8ZIu+N4G0Xro38h4gNI2nnrTkS0OXYsRhwrzGQ1CIZmn6lozNXoicKou9/S58O5
         fOQg==
X-Gm-Message-State: AC+VfDw3MxFYfpZ+E+kqnaBwN8TiYJiDaGaca8nLrUpCXrpO4ruhKLns
        Y7EJiQGqcSLKuD49aR9tahlFIA==
X-Google-Smtp-Source: ACHHUZ4QE6eIoIvy0EpNGIEH38hTHzaiIHXx5LXq/Y70Do4Pc/zfgwH1S1QF+x5O3u1kSBAlWZQGqw==
X-Received: by 2002:a17:902:e5c9:b0:1b0:637e:e25a with SMTP id u9-20020a170902e5c900b001b0637ee25amr7089787plf.67.1686162919834;
        Wed, 07 Jun 2023 11:35:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id je12-20020a170903264c00b001addf547a6esm10746876plb.17.2023.06.07.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:35:19 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] net: phy: broadcom: Rename LED registers
Date:   Wed,  7 Jun 2023 11:34:52 -0700
Message-Id: <20230607183453.2587726-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607183453.2587726-1-florian.fainelli@broadcom.com>
References: <20230607183453.2587726-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e4203605fd8e65a5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e4203605fd8e65a5
Content-Transfer-Encoding: 8bit

These registers are common to most PHYs and are not specific to the
BCM5482, renamed the constants accordingly, no functional change.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/broadcom.c | 10 +++++-----
 include/linux/brcmphy.h    |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 822c8b01dc53..57a865aa1fe5 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -414,13 +414,13 @@ static int bcm54xx_config_init(struct phy_device *phydev)
 	 * these settings will cause LOS to malfunction.
 	 */
 	if (!phy_on_sfp(phydev)) {
-		val = BCM5482_SHD_LEDS1_LED1(BCM_LED_SRC_MULTICOLOR1) |
-			BCM5482_SHD_LEDS1_LED3(BCM_LED_SRC_MULTICOLOR1);
-		bcm_phy_write_shadow(phydev, BCM5482_SHD_LEDS1, val);
+		val = BCM54XX_SHD_LEDS1_LED1(BCM_LED_SRC_MULTICOLOR1) |
+			BCM54XX_SHD_LEDS1_LED3(BCM_LED_SRC_MULTICOLOR1);
+		bcm_phy_write_shadow(phydev, BCM54XX_SHD_LEDS1, val);
 
 		val = BCM_LED_MULTICOLOR_IN_PHASE |
-			BCM5482_SHD_LEDS1_LED1(BCM_LED_MULTICOLOR_LINK_ACT) |
-			BCM5482_SHD_LEDS1_LED3(BCM_LED_MULTICOLOR_LINK_ACT);
+			BCM54XX_SHD_LEDS1_LED1(BCM_LED_MULTICOLOR_LINK_ACT) |
+			BCM54XX_SHD_LEDS1_LED3(BCM_LED_MULTICOLOR_LINK_ACT);
 		bcm_phy_write_exp(phydev, BCM_EXP_MULTICOLOR, val);
 	}
 
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 251833ab271f..ab21b8a1b2c8 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -206,11 +206,11 @@
 #define  BCM_NO_ANEG_APD_EN		0x0060 /* bits 5 & 6 */
 #define  BCM_APD_SINGLELP_EN	0x0100 /* Bit 8 */
 
-#define BCM5482_SHD_LEDS1	0x0d	/* 01101: LED Selector 1 */
+#define BCM54XX_SHD_LEDS1	0x0d	/* 01101: LED Selector 1 */
 					/* LED3 / ~LINKSPD[2] selector */
-#define BCM5482_SHD_LEDS1_LED3(src)	((src & 0xf) << 4)
+#define BCM54XX_SHD_LEDS1_LED3(src)	((src & 0xf) << 4)
 					/* LED1 / ~LINKSPD[1] selector */
-#define BCM5482_SHD_LEDS1_LED1(src)	((src & 0xf) << 0)
+#define BCM54XX_SHD_LEDS1_LED1(src)	((src & 0xf) << 0)
 #define BCM54XX_SHD_RGMII_MODE	0x0b	/* 01011: RGMII Mode Selector */
 #define BCM5482_SHD_SSD		0x14	/* 10100: Secondary SerDes control */
 #define BCM5482_SHD_SSD_LEDM	0x0008	/* SSD LED Mode enable */
-- 
2.34.1


--000000000000e4203605fd8e65a5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJTMJUfr7888Gk2o
pTIDDKyCIz7i6Am61JYVmZfFD9hkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDYwNzE4MzUyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBihQkEpF/XExa465wp41URKAVwO51LluFN
vhcpge2TPQClyRd1aCg6ZoCfCc0VR38ukXZyxhWSvAFI1LjahW5Zlk/7TQNrkVM8vKZFkETwFPDD
xe5+y1/NukYqparwk0s4nJn6UDjxdRgu18To8kzcTBeg4mC/GvnTGRn92dL39tlfBiZ9KaA12vKw
5HFCWUMUMaenR/FeZJVCHM+Chf1OKUTCWp6NlsD0fmXLC6Oea4R4Hpxnj9fVL30Er2GmFYSmI+Xe
ki2OavuUqPdxpsRnfPaoDBq65Za+BJIFF5J6wD8yHjxZDOdZuKXMRg3WRC0+xOEfm7KU+MtZqwA3
z/Hu
--000000000000e4203605fd8e65a5--
