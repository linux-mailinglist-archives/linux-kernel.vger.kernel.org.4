Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D3732096
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjFOUG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:06:26 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD33295D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:06:25 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75d4f12d4a3so1484185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686859584; x=1689451584;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YBp/Rtkye9A2SX5W55+KGtFjX2gPNbk20w1lf0dP+p4=;
        b=B8t8Z36jQgm5n3pso0+0nMsgQ1tUcK7aHSbUbYa6CRrOJSvzl27ijBFH4ljAmaN4o4
         F+dWdmQDrQOOhwyC3rhGg9VhrZCVTaHXIjV+ciUpnb2PDuSsrV1O8bDI+xxTR/WRVLz6
         C15SryyistAXsQy4eLKW9bEDKg+edt5Mfz7/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686859584; x=1689451584;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBp/Rtkye9A2SX5W55+KGtFjX2gPNbk20w1lf0dP+p4=;
        b=PIsesXOA8ABAKdyoosdN8IAUW7t3Q/1vOLdzV1dV8iwUU+lVUiyifYb5GG40c+Wkqp
         KfTKNdMAz4NJMRxbeIsi5kGyg8/TCmrPAI4E8CqooONvGejws2i9oMYkYz7RDKaL4kJX
         lafhLmxfo3mPJnikOwXbfcX0e7vH9CwFiU0EkWJK1uR3nUkZOztmUyss6O71WtnV/b9+
         0+J9G8ZvU1kKNeEPbXGXn2vZDJ/K6bFvd1/rLqPYv3cpyPWYVgv0PIC479fJ/6mwQZWp
         I61iRf4hZGsp/tDFV8aRYeXm/bSoHWr4foWkHu+vC3rC6i7APpE5Uqagl8LqjM3issWO
         CMDA==
X-Gm-Message-State: AC+VfDxJrKn0Vpfprtp/1IN1xZBtZRertss/pywl6HMQ+2R7gfDExw2o
        zzySY6pynOuAg3fYa4jVmfdGZg==
X-Google-Smtp-Source: ACHHUZ4I8QqRqxVTJ00VzyT9TWYR5uen+/Rc2bZUMBzr1gHqwNZ161+yG9cqJ5FNF2WEFkeOMAPi8Q==
X-Received: by 2002:a37:688f:0:b0:75d:44af:19f2 with SMTP id d137-20020a37688f000000b0075d44af19f2mr19579005qkc.11.1686859584470;
        Thu, 15 Jun 2023 13:06:24 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a142400b0075ceca53e84sm5721407qkj.15.2023.06.15.13.06.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2023 13:06:24 -0700 (PDT)
From:   Justin Chen <justin.chen@broadcom.com>
To:     linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org (open list:BROADCOM BRCMSTB USB2 and USB3
        PHY DRIVER)
Subject: [PATCH 1/2] phy: usb: Turn off phy when port is in suspend
Date:   Thu, 15 Jun 2023 13:06:16 -0700
Message-Id: <1686859578-45242-2-git-send-email-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686859578-45242-1-git-send-email-justin.chen@broadcom.com>
References: <1686859578-45242-1-git-send-email-justin.chen@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000055dd9f05fe309a04"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000055dd9f05fe309a04

The COMMONONN bit turns off the PHY when the host controller puts it
into suspend state. This can happen during the following...
- Nothing is connected to the port
- The host controller goes into low power mode whatever due to auto
  suspend or system suspend.

With COMMONONN we also must unset U2_FREECLK_EXISTS since the UTMI
clock is fed by the PHY.

With these changes we see a power savings of ~12mW when port is in
suspend.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 15 +++++++++++++--
 drivers/phy/broadcom/phy-brcm-usb-init.h          |  8 ++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 76cf4280d7ed..4c10cafded4e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -59,6 +59,8 @@
 #define   USB_CTLR_TP_DIAG1_wake_MASK			BIT(1)
 #define USB_CTRL_CTLR_CSHCR		0x50
 #define   USB_CTRL_CTLR_CSHCR_ctl_pme_en_MASK		BIT(18)
+#define USB_CTRL_P0_U2PHY_CFG1		0x68
+#define   USB_CTRL_P0_U2PHY_CFG1_COMMONONN_MASK		BIT(10)
 
 /* Register definitions for the USB_PHY block in 7211b0 */
 #define USB_PHY_PLL_CTL			0x00
@@ -90,6 +92,8 @@
 #define   BDC_EC_AXIRDA_RTS_MASK			GENMASK(31, 28)
 #define   BDC_EC_AXIRDA_RTS_SHIFT			28
 
+#define USB_XHCI_GBL_GUSB2PHYCFG	0x100
+#define   USB_XHCI_GBL_GUSB2PHYCFG_U2_FREECLK_EXISTS_MASK	BIT(30)
 
 static void usb_mdio_write_7211b0(struct brcm_usb_init_params *params,
 				  uint8_t addr, uint16_t data)
@@ -140,13 +144,17 @@ static void xhci_soft_reset(struct brcm_usb_init_params *params,
 			int on_off)
 {
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+	void __iomem *xhci_gbl = params->regs[BRCM_REGS_XHCI_GBL];
 
 	/* Assert reset */
-	if (on_off)
+	if (on_off) {
 		USB_CTRL_UNSET(ctrl, USB_PM, XHC_SOFT_RESETB);
 	/* De-assert reset */
-	else
+	} else {
 		USB_CTRL_SET(ctrl, USB_PM, XHC_SOFT_RESETB);
+		/* Required for COMMONONN to be set */
+		USB_XHCI_GBL_UNSET(xhci_gbl, GUSB2PHYCFG, U2_FREECLK_EXISTS);
+	}
 }
 
 static void usb_init_ipp(struct brcm_usb_init_params *params)
@@ -320,6 +328,9 @@ static void usb_init_common_7216(struct brcm_usb_init_params *params)
 	/* 1 millisecond - for USB clocks to settle down */
 	usleep_range(1000, 2000);
 
+	/* Disable PHY when port is suspended */
+	USB_CTRL_SET(ctrl, P0_U2PHY_CFG1, COMMONONN);
+
 	usb_wake_enable_7216(params, false);
 	usb_init_common(params);
 }
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index f9fbf8fb80e5..c1a88f5cd4cd 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -34,6 +34,14 @@ enum brcmusb_reg_sel {
 	brcm_usb_ctrl_unset(USB_CTRL_REG(base, reg),		\
 			    USB_CTRL_##reg##_##field##_MASK)
 
+#define USB_XHCI_GBL_REG(base, reg) ((void __iomem *)base + USB_XHCI_GBL_##reg)
+#define USB_XHCI_GBL_SET(base, reg, field) \
+	brcm_usb_ctrl_set(USB_XHCI_GBL_REG(base, reg), \
+			  USB_XHCI_GBL_##reg##_##field##_MASK)
+#define USB_XHCI_GBL_UNSET(base, reg, field) \
+	brcm_usb_ctrl_unset(USB_XHCI_GBL_REG(base, reg), \
+			    USB_XHCI_GBL_##reg##_##field##_MASK)
+
 struct  brcm_usb_init_params;
 
 struct brcm_usb_init_ops {
-- 
2.7.4


--00000000000055dd9f05fe309a04
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQagYJKoZIhvcNAQcCoIIQWzCCEFcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3BMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUkwggQxoAMCAQICDCPwEotc2kAt96Z1EDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjM5NTBaFw0yNTA5MTAxMjM5NTBaMIGM
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0p1c3RpbiBDaGVuMScwJQYJKoZIhvcNAQkB
FhhqdXN0aW4uY2hlbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKX7oyRqaeT81UCy+OTzAUHJeHABD6GDVZu7IJxt8GWSGx+ebFexFz/gnRO/sgwnPzzrC2DwM1
kaDgYe+pI1lMzUZvAB5DfS1qXKNGoeeNv7FoNFlv3iD4bvOykX/K/voKtjS3QNs0EDnwkvETUWWu
yiXtMiGENBBJcbGirKuFTT3U/2iPoSL5OeMSEqKLdkNTT9O79KN+Rf7Zi4Duz0LUqqpz9hZl4zGc
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINtZb5cf9qd15jixqpoWNzibUdqt9XGAeZoV
yIB+dGwQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYxNTIw
MDYyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAUGRd6J79XMl1TNQvpI+YVqnKhJc0Iron9sd1BE1l5Kj+8tmTLD940
6IBH6SmD8E1sO55SBgmbexF5vSJnnnT04HcorzAneUj11TZyC9s9OoTT1gf7NIc+/LFDozdFPtUu
yotA+s1v1tTMjEg3Hl9YDpPqVucjjeSc9GN6QeMHRA4+WV6BYyEJzhZtgzHMqSusIfh9jo65paxP
IKTqJLoQ0oH56T3UoJX5C9EdMeAUppuc+hFC4MDuUnP4msQ7yrb3cyiOkLjGgGZKQ9fdIDXoz5Uh
GiaWr2jH7PF3gKx+yLyHfSM0dbftCImKn823a5e4Tdf+FXMbb5WVpqLm3GtK
--00000000000055dd9f05fe309a04--
