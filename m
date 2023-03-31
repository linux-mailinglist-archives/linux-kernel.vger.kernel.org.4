Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302316D2A05
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCaVdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:33:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5091BF7C;
        Fri, 31 Mar 2023 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680298401; i=w_armin@gmx.de;
        bh=EBWPFpbCMT46T6rEenKWgprKQmJ4QU39rhCZdbZ7H2k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=POPqArVSbsfbx7JzL1tW34DbQS+0zZGk7kT0FMHmyWu87oJyKOOSfuhyBhYB2Ee1M
         vpAKSE+Tqn3S4at6nE3A4JhLkwiMjHz5/LGvgv/51OpDwVuXb6YQetxWxxh5/XP9kM
         pfJkh1bUHsl331GnvOj8bK9fdRFRqjyYEzv4LC4rdJT5nc9jWt6Ed50TPzWuZyqptJ
         Ek0IKxWuzQbadnKr/EJ6wsiUhBJeRQdS1T4HtndczuBhq9sRuvDnRqaRmydLCV6kYH
         CE9noWONiaRVRhd3wX9E1kPkGku2E0EygPuJi4Op9N/5Fh/SogVehz6avuTBjqy3Yu
         pTPySEgRRAJ7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2f9b-1pieI20msx-004AHM; Fri, 31 Mar 2023 23:33:21 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, mirsad.todorovac@alu.unizg.hr
Cc:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/x86: think-lmi: Fix memory leak when showing current settings
Date:   Fri, 31 Mar 2023 23:33:19 +0200
Message-Id: <20230331213319.41040-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hVi4JZhY5ITHBCZ96XKgijEgPxTZgmr/KMgFg/ieta1PObiGlDn
 JiLQJ8moCnYNhHyWNcKVjAa3hCmVVmpMkk6US84PBhU4foP1SDEFXGm6CR9BPsHsFTs2zL7
 hpSsqzTzQwM8sTqY6kOWdEKA5ZJ29wT5ofSBqKUk8R4amJrNSgraYeYwIkJmG2+nUnluDdH
 z7i/xp/aAlB3YUxfzmffw==
UI-OutboundReport: notjunk:1;M01:P0:3yD1piXwDKw=;Ee56+PiU5hMw9gDLK0SwwwcJZGx
 h3U8PXO4P5txxb+W1ze0xn0mfHxo131dYWZc7NsFi0IlzZX52frWKcotbQbn9UkXUPSbt/mz6
 Xnj/6tKhV/4NW8sxGV/AMfKFrsPPWN4m+JIFwMtQGK5HhHv2L1GqGX/QzQA0/jGn1OwDBIAMQ
 +lg/u5qdRR4ZwaNrFeMS9vqTIxMl3AxarmsIurQM9L07TiQhZmZSlnctpIkWJsDZALxSJSEBv
 aw0jfIHmiFOPOZKXIvVeSj6olZeIkajBCYZNfIsNM4rTVweP5xbynNF+Exerl/zDbtalAtd/A
 xVlDrvwMUYUoX9mzjnyx+IGCjmC1U4wxuC0ADErYomLx4tJuLEAyWxQXPauKb79NUlE9KueFr
 iI0es9zUy8ANM8MZoHJsxlkN/lNJQnS0Z8CMdRvg4qay0djYv94UkxqBWQOFBsKQpfXAg+xFV
 Y9jj5nr1wqvYUuh8i8CJ17YauDHYfElSa3xljzKwS229UhCuszQFB2RIcPBjtO46ZhPQsST9+
 1+Zya9V5AdHvP2N/399edPHocke8NMMAHMP+/mmQ+R5y4z+hOOj3zIfDbk7MKC4e322P9FFHI
 uLny7qDCwe2EZU5JSUPR2WtnIa0Hj6Ysl/KIbbQLtpOZa/RjRg5Sp5Ya0UoF4cCHugWFx+HkX
 vn+QUSau5qrYGp4bRyLlXNxdJpflj1p/1vEcp9VvGRB3SB8G6WK85kzVun6DYeWkrXchqe/+b
 w5TvT9+v//FNPdfPcU43GHgpTTeV2/itTEntFwr96HXFtPsUtiat5lRvMJXqeO0ETN1kCi+0Y
 wm6KC8Q3iF7FcnJd2rVCbaZeyXe1CIBUp3mT83nA8to4HSt3YLP/Fs9YQLtNzpMfd30R9mE4Y
 +YJs2bRrLtW7y4Hlkd2Z2A+1cUw77pdKY1iEVEzIpqZCkYnoIb3FxRPFZNXeCtzzItydZlLEx
 /MVuhHtd2JpYXz4Wm7mSvo8XmMM=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When retriving a item string with tlmi_setting(), the result has to be
freed using kfree(). In current_value_show() however, malformed
item strings are not freed, causing a memory leak.
Fix this by eliminating the early return responsible for this.

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-=
868bf0eca0b8@alu.unizg.hr/T/#t
Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Fixes: 0fdf10e5fc96 ("platform/x86: think-lmi: Split current_value to refl=
ect only the value")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v3:
- Fix Fixes: tag
- Add Tested-by: tag
Changes in v2:
- Add Reported-by: and Link: tags
=2D--
 drivers/platform/x86/think-lmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think=
-lmi.c
index cc66f7cbccf2..8cafb9d4016c 100644
=2D-- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject *ko=
bj, struct kobj_attribute *a
 	/* validate and split from `item,value` -> `value` */
 	value =3D strpbrk(item, ",");
 	if (!value || value =3D=3D item || !strlen(value + 1))
-		return -EINVAL;
+		ret =3D -EINVAL;
+	else
+		ret =3D sysfs_emit(buf, "%s\n", value + 1);

-	ret =3D sysfs_emit(buf, "%s\n", value + 1);
 	kfree(item);
+
 	return ret;
 }

=2D-
2.30.2

