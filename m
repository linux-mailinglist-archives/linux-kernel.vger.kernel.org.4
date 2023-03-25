Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23956C89D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCYBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCYBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:16:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19E19C40
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:15:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t15so3391840wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679706957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91JluRBFfo+dlggEBHCntk5mXH0WhZHFPFTV+W3q65A=;
        b=jua+I+0LERUgkWhnDauB+vRIJ3XOFGdJc1FIdxQJGTpFXnUYFpnl1M0FyI4P2Z1W7y
         SBkIyY/OfoMI0psdCONRTL4ZS63kHA2iqXyIM0nN/dGJZAZmcA5gYP6rOxZOgHRKM7f6
         bHFgD/PQb+oenN+MNtzTDoPuecsojvuxoHLbIEEY8nhj6P8lgUbQ8c3QGuT0p6uPGR5x
         JUPBdI2HQoxVGYUSiWLE/4xzQWlwguwZ0huEk1hOxrzfTluA8x98Ua7M0Bra5mGAmbkK
         TKZk/uzeOLWEqXSzFBx1aqglCYn7EHy/Y6qw/hMeDxv2Pb2YBsd0Tec1Zc1da1LXTwPB
         3dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679706957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91JluRBFfo+dlggEBHCntk5mXH0WhZHFPFTV+W3q65A=;
        b=STzyw5nVQ0Adyxlxotn5ZGrLiMKCYpOSyKxQpoW7Nh15uNF+jVyERxmeMzkhGLQ/5O
         yuqU4j2ZV45a1zWReFuTnbovZnnVf07HiEmp+sZzl/4axBGNrUC8Fb0+IkcZfym8aAE5
         gmp0y4eRFCaxwz4uegC22EPJSPtyUW269nuZ9v9Ecgc2xFGakVe84AwkMVCj4kdg2t8d
         tLlNhf4wB5KiGHAdNTuc6j06/Ylfdb7Av1HEtXY4US+acOWPDKK5kGi1z0J9Hftpi+3I
         5HEuzTLIN5Z92z9GXJRx7i3/OQ6Jp337DIUbn9RB0YfhgxOoEYn1XA4fBJ5g1mmEPUPp
         heSw==
X-Gm-Message-State: AAQBX9esGtJmgvabVN1D5b6b7liJzpcpTyzHAbqzrW11a0lj1iVhlTda
        0YPBq0A0np6KPpQ8jM+xKBQz3g==
X-Google-Smtp-Source: AKy350Yjykwk41eTTI/jmOLP4o6VFGNDREt+tUzeDa17Mh38H5PS9kamgNeEo2vSNrOoeb0jsRZG/Q==
X-Received: by 2002:a05:6000:50b:b0:2db:bca:ac7d with SMTP id a11-20020a056000050b00b002db0bcaac7dmr3475033wrf.67.1679706957465;
        Fri, 24 Mar 2023 18:15:57 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm19456548wrr.88.2023.03.24.18.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 18:15:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        andersson@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RFC PATCH 1/1] usb: typec: tcpm: Support role-switch remote endpoint in connector
Date:   Sat, 25 Mar 2023 01:15:52 +0000
Message-Id: <20230325011552.2241155-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325011552.2241155-1-bryan.odonoghue@linaro.org>
References: <20230325011552.2241155-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now in TCPM when we want to send a role-switch message the
remote-endpoint must appear inside of the TCPM bound node, not in the
connector associated with TCPM.

&typec {
	status = "okay";

	port {
		typec_role_switch: endpoint {
			remote-endpoint = <&dwc3_role_switch>;
		};
	};

	connector {
		compatible = "usb-c-connector";

		power-role = "source";
		data-role = "dual";
		self-powered;

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
				typec_mux: endpoint {
					remote-endpoint = <&phy_typec_mux>;
				};
			};
		};
	};
};

This change makes it possible to declare the remote-endpoint inside of the
connector of the TCPM e.g.

&typec {
	status = "okay";

	connector {
		compatible = "usb-c-connector";

		power-role = "source";
		data-role = "dual";
		self-powered;

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
				typec_role_switch: endpoint {
					remote-endpoint = <&dwc3_role_switch>;
				};
			};
			port@1 {
				reg = <1>;
				typec_mux: endpoint {
					remote-endpoint = <&phy_typec_mux>;
				};
			};
		};
	};
};

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1ee774c263f08..a62fecf3bb44c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6515,6 +6515,7 @@ static enum hrtimer_restart send_discover_timer_handler(struct hrtimer *timer)
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 {
 	struct tcpm_port *port;
+	struct fwnode_handle *fwnode;
 	int err;
 
 	if (!dev || !tcpc ||
@@ -6582,6 +6583,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 		goto out_destroy_wq;
 	}
 
+	if (!port->role_sw) {
+		fwnode = device_get_named_child_node(port->dev, "connector");
+		if (fwnode) {
+			port->role_sw = fwnode_usb_role_switch_get(fwnode);
+			fwnode_handle_put(fwnode);
+		}
+	}
+
 	err = devm_tcpm_psy_register(port);
 	if (err)
 		goto out_role_sw_put;
-- 
2.39.2

