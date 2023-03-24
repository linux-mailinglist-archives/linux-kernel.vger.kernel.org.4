Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396746C86D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjCXU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCXU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:26:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A001BAF2;
        Fri, 24 Mar 2023 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679689591; i=w_armin@gmx.de;
        bh=iBwcc9Yx9rNUnbmKzEiEQczbMJUikxgDl+84KQ+TaMc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bZusCgVqqvjz9PVIOZtmG+JPZj2CK/4ZTrp33vSdPDCxEreJMXgou0FtssiE0N0Y1
         hNWEkelkCsrkC3uC/LaLvwU/Ub5zdZAohvPZ6LXh81PtQNT809nsNatLOeGEhD7h4T
         Xt1ZYjnhvPpNSzvpwXzi6meGeXCxqbh3/LgCGLPZqQOsc2GO2p2TqqcC2nSG/aB2gp
         alQAnn8OUjX5Kxf9EFRMVJJQ5u9j5GlYP5L2yZkgY38CVFvrnUJZBRegja5WGNf89O
         UaYz3brtOxTDE+wQ0l5sZq8ioS3lhJdnRfihIWSoGmI1QltkXk+AmxGNzKg9YqaZfZ
         6kiBUufmQKhvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MC30P-1plcLK2G45-00CRBo; Fri, 24 Mar 2023 21:26:31 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ACPI: EC: Limit explicit removal of query handlers to custom query handlers
Date:   Fri, 24 Mar 2023 21:26:26 +0100
Message-Id: <20230324202628.76966-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230324202628.76966-1-W_Armin@gmx.de>
References: <20230324202628.76966-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ij0/krkURmRj6a63ZT1bdR+W0yrB6Cqe37dgn3hdvawhyroSfm
 14UMQKm0JXaWPIpnkSS7aK5btkKmoBLa9McnkbEyHSbcXDTxoJrl77LRUuGALmLByEzmpaE
 R3iGF3eHQquWApSeZn1/KuFs6w/bcOgDTxj0/lxOCaD0E1IoH9Wo39Frvd7cATzOvt5fu5Q
 cYNJNZbS920cv1mD3wOyA==
UI-OutboundReport: notjunk:1;M01:P0:vxnn8PaQXUY=;DPaNlF7qzJNDDfjL6hDG1temh6E
 JoSdMbgWrMHeXI6XGO93I8+ZF5FRxxf46nP4ZhXjj3zHj3ZdOFW6pH8jRMQo1MAOjToJdwokC
 5SCc838D1HxzYZeTNPcoWCDZE4GzB1i/q0ZRhkIV+owhCfqgETKfrgqxJVZgcso6bjUpJA4lC
 Uw4+cS7FAmbaK9iDaOU+c16a7YQTAlV7EHu/pIr7UbIfrVhFQLpE76fvk8Ja3zIG7jZMcilzB
 7mrWASvNRCmjtkDqiFuqccpfIaHLr00bS38PrTju6sxZxKW+qlXzS3zmdInc3YcUaR/4r7R2O
 Nz/h0UIL469w2fnObbjJxZv8akX0wQa5wzMkwutCU/ChVelC0Vlr1zSl/Sl5bIh0EiqjItHHd
 nzGMdMYVOstnxS1URlgjJcRbLFvfdw+GE161wWl9nMGfnZY5fVO3ZccNj+Q1U47v/h05sKh72
 LpOimQIDt3LnqQXjhIzAvtd9mpY2uwLjvFXQhFMc4YT+umdECUAzHgHJq6Rj9dX9slyY+nPD+
 Uls2bX8PodmAU7F404xdFXJRO9ccxbd7tijg1lTGcu6EAhfGpNwiKogsbvfrzrB10zpFtWFB4
 log0/TTOgI9kEZGZyXf3SkQdDsfu8fBX4g6IwSwLqYGQ19w/X4l6vwX1P/JbE8ToiqwnlgB7T
 J7TPz9zUSSzaFQY/2Aqi8vTQ/ijF0KxhctddadhXDz/ON+tZz0sop/lYNvRJ6GxjxiCt2Y9Zq
 1CHCpTCtgZ7E+oB+2T5vl5Cq977VYFBf/0q6Mttyj4+ls2vz9BTsRpWd1MMRCtwYJu+/TRfnJ
 UqISKu1R6uqDLyjv0qUUOpwnVywwKuIO9dqXIHa6nLGkVd+H/E1HXkMW14/6ssF9is45EBxf2
 Dz2sB+ljAVWp60p+baJDfbocThzHd3S+OmzQ9BcFH0z49heVj+EvVMzaatz/j+9vcseeLFH/A
 Ab6H/0UMk4t5aJu6wnJDHfW55/w=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ACPI spec part 5.6.4.1.2, EC query handlers discovered
thru ACPI should not be removed when a driver removes his custom query
handler. On the Acer Travelmate 4002WLMi for example, such a query
handler is used as a fallback to handle the EC SMBus alert when no driver
is present.
Change acpi_ec_remove_query_handlers() so that only custom query
handlers are removed then remove_all is false. Query handlers discovered
thru ACPI will still get removed when remove_all is true, which happens
on device removal. Also add a simple check to ensure that
acpi_ec_add_query_handler() is always called with either handle or func
being set, since custom query handlers are detected based whether
handlers->func is set or not.

Tested on a Acer Travelmate 4002WLMi.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 105d2e795afa..f84905dbd8ca 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1083,9 +1083,12 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u=
8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data)
 {
-	struct acpi_ec_query_handler *handler =3D
-	    kzalloc(sizeof(struct acpi_ec_query_handler), GFP_KERNEL);
+	struct acpi_ec_query_handler *handler;
+
+	if (!handle && !func)
+		return -EINVAL;

+	handler =3D kzalloc(sizeof(*handler), GFP_KERNEL);
 	if (!handler)
 		return -ENOMEM;

@@ -1097,6 +1100,7 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8=
 query_bit,
 	kref_init(&handler->kref);
 	list_add(&handler->node, &ec->list);
 	mutex_unlock(&ec->mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
@@ -1109,9 +1113,15 @@ static void acpi_ec_remove_query_handlers(struct ac=
pi_ec *ec,

 	mutex_lock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
-		if (remove_all || query_bit =3D=3D handler->query_bit) {
+		/* When remove_all is false, we only remove custom query handlers
+		 * which have handler->func set. This is done to preserve query
+		 * handlers discovered thru ACPI, as they should continue handling
+		 * EC queries.
+		 */
+		if (remove_all || (handler->func && handler->query_bit =3D=3D query_bit=
)) {
 			list_del_init(&handler->node);
 			list_add(&handler->node, &free_list);
+
 		}
 	}
 	mutex_unlock(&ec->mutex);
=2D-
2.30.2

