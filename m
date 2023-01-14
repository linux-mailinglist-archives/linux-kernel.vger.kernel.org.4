Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28766AA38
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjANIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjANIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:51:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895856E84;
        Sat, 14 Jan 2023 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673686257; bh=ecSPvHCNjAvVeCQzbDjFrZEbtxhwySp2CjVRnX3yiRY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jl/+AWUSgF3KF0rnllZ9T2SkWBIYgsomNDbLkujsOkL8IOaVDqeIATWN1TdUVgQNY
         gGamUDmP/FJSQa2xo1lNYRv2CmvVYhCJVErVkXwD2S+p/1k7UPbuto207VflvxFk5e
         rIr/2XaEt6vi5gTfEk7XohDJC+0n1JWULXDPSEzeCKYGTkfI5vcZzk+F1E/kLp8eGh
         pgMpAXE+J512DtY9yKIJD0/BwyYgiTZE81qnp163xI5+KSkM0mV0dTmWPh8HIyxksF
         hkXk5D9GUzMFq1OTYCwkdmM1MoSjzgS7TIo+uqvjWgvwapGH8lAGeL99EuYoevwpMi
         Lj1KxWhK5nBlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIMbO-1pUtS03vpE-00EJoI; Sat, 14 Jan 2023 09:50:57 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ACPI: battery: Fix missing NUL-termination with large strings
Date:   Sat, 14 Jan 2023 09:50:50 +0100
Message-Id: <20230114085053.72059-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230114085053.72059-1-W_Armin@gmx.de>
References: <20230114085053.72059-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wnx0zZfkWOTNqc0y565JEVWCMcUdeD35UbCLS0wpCTRKXW7GKsx
 3WiNFgzjgxLl18K3aaWZXQb7Lg0Dm6qGydvsVav90ct5FK6YQa3SpJCGMMPYuOC72Ihxm37
 x2VJoELK9obkL71bcjeREJ564RUAIlc7CPo/6vglQYx0fz+4YUW7CZhuxZwy9zQuIFATpBA
 Ez/Su25vigRIIWEZj4dVA==
UI-OutboundReport: notjunk:1;M01:P0:95BV4QVoCTE=;Q2azfCmrGSrvVBLlUaLLdyO8IfV
 /j0zeGDUEFJb/Dq+GzOFRCBrqSaqcQag6SPY1/VkamYCWCaCP0vUnn6BcF4q7Yxo5DF8914PZ
 hxIQ2s/MIywNBVPGVdNLFBlu2PtoJto1pFb3xniWmptFzmrjr4xwei1U0EYnxjyCm7yVKkA2g
 ZGXXHXo9kfohtOi36X0nFBSiZOaGaxtMGsRbMTq05Xbej0NsiqSY4yI1GtsQEFEM6lLa7Vi0m
 Kjc5gWZk6o9Vo/6S+RdvrJQ7WhSOEkeCnPoKCOEG0+gMHjUtws10tf2ZcrmOOq4zO1174i5dD
 9Yd2LlhgVQxZYPVpAjQQdnRL7VHu8daZJ1VLHis9kd1fC8tg4gSYWNWLNw1cJCkMVUMgmwQVj
 Xxsirr3WNuqeDdqbOnLJEJ2RlrccTEvHv3NwkQs/B4NAs+Rj42Pilye/PKoTnzlRJe27HFggw
 34DTA2VQ6BDnJv4WjSyPWpXcEqbnFi7QgNQ2Y6uo69ZhJt9hThjrWvwT4oMgDlR2/UtjN9VLv
 UnIX5JRCa5L1hmMmuh0Io9e2Gwaa8vfGqCCEc15frbk6ZpyGhB72Kf5XunD2sCsA/005NUziH
 NDKX7G9Gt/68KMbrfEfFl2aYBONLn1AmxbAKCJmZSd9jB0pUkel1gjsbumg2w68jVmeO4YFJ1
 IHwmyCJWUPs24VX+JZUnaCVx/xYbH/yfkyULzIyDLvK+QByRsp6X9gWHS6XMp7beiYrjbZjf0
 LkF72Ft83ecD7CrZoWSCzEa220PpdJ0TM/bzIXtE+ECP14RqMM77C2bNRcm1KA0SBj5QnM1fv
 VB5H7q4GumTQPS/I7h3LRbJQ9YzraiLnRIqUO8YJWfwPu21Xt/oackE2Shnkwav2g9eaMnnLV
 2S3S4n09x93bN5jKX0SJtJqwMyHd9a5F+JNzNx5unS9GX+Cm6VpTIfpk8REYrbhHw7vGnO1Vs
 nZCLtvg7XCPnxxLYxnU2OYVJs+E=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When encountering a string bigger than the destination buffer (32 bytes),
the string is not properly NUL-terminated, causing buffer overreads later.

This for example happens on the Inspiron 3505, where the battery
model name is larger than 32 bytes, which leads to sysfs showing
the model name together with the serial number string (which is
NUL-terminated and thus prevents worse).

Fix this by using strscpy() which ensures that the result is
always NUL-terminated.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f4badcdde76e..fb64bd217d82 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -440,7 +440,7 @@ static int extract_package(struct acpi_battery *batter=
y,

 			if (element->type =3D=3D ACPI_TYPE_STRING ||
 			    element->type =3D=3D ACPI_TYPE_BUFFER)
-				strncpy(ptr, element->string.pointer, 32);
+				strscpy(ptr, element->string.pointer, 32);
 			else if (element->type =3D=3D ACPI_TYPE_INTEGER) {
 				strncpy(ptr, (u8 *)&element->integer.value,
 					sizeof(u64));
=2D-
2.30.2

