Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8E6A7D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCBJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCBJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:02:08 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31F3B219
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:01:54 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230302090152epoutp04acc1282dd02f1bda11ab30cd2b162c9e~Ijqexa79P2493224932epoutp04E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:01:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230302090152epoutp04acc1282dd02f1bda11ab30cd2b162c9e~Ijqexa79P2493224932epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677747712;
        bh=0uzqFSfpAvdZMsnO58nFZF6unKH5wBEwN0q4tolro1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmcYIYgtl6vUeydt6eEyHLLh60OEm/qFXq1DDJ/dkFNy0rAGpyt6EgLzx+rRKt1Pd
         ZTMHxAtOPMcEbYllzfxLSbWKitWPV0SXBZhltRg/A49Ajkd1zt3y0ajPUcWchy6fW0
         wLe4kyN1kXkVpHVajYT5Tw/yiDEfthNn7Q955mIg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230302090151epcas1p19c0f3b0e223801c09dad12dc3d1d132a~Ijqedr5wQ2953829538epcas1p1C;
        Thu,  2 Mar 2023 09:01:51 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.226]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PS4q24PkQz4x9Pw; Thu,  2 Mar
        2023 09:01:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.AC.12562.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epcas1p2bad39de9aa367644cda3ffcb4dd4a612~Ijqcc4kJy0051500515epcas1p2D;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302090149epsmtrp17fe465779d69392a29ce9dab828f2bed~IjqccNTcq0666306663epsmtrp1v;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
X-AuditID: b6c32a36-e59fa70000023112-8f-640065fd0e35
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.2E.31821.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epsmtip20792e78de5418056689e323c7da60751~IjqcQmmkh0659906599epsmtip2n;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v4 2/4] extcon: Added extcon_alloc_cables to simplify extcon
 register function
Date:   Thu,  2 Mar 2023 18:01:41 +0900
Message-Id: <20230302090143.46678-3-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230302090143.46678-1-bw365.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmge7fVIYUg9XLTC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGed6T7AWvJKv2HtoE2sD43nJLkZODgkBE4nvL+ey
        dTFycQgJ7GCUaH61gQXC+cQo8a93KhOE85lR4uvFbjaYlm9zH7NDJHYxSmz+8Ruq/xejxJnl
        81hBqtgENCT2XGwASnBwiAgUShzuzwYJMwuoSTxYtZEdxBYWSJBY8fg4K0gJi4CqxILNsiBh
        XgEriZ2vJ7FA7JKX6P73B8zmFLCWeDO5iwWiRlDi5MwnLBAj5SWat85mBjlBQmAXu8Ti89OZ
        IZpdJNZP+cQIYQtLvDq+hR3ClpJ42d8GZadLrLxyB8rOkXh9vx2q3lji3du1zCC3MQtoSqzf
        pQ8RVpTY+XsuI8RePol3X3vAzpcQ4JXoaBOCKFGW6H7wggnClpRY/PQO1EQPids/bkPDs49R
        Yv7lv0wTGBVmIXlnFpJ3ZiFsXsDIvIpRLLWgODc9tdiwwAgewcn5uZsYwelOy2wH46S3H/QO
        MTJxMB5ilOBgVhLhXXj7T7IQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgcm3LySeEMTSwMT
        MyMTC2NLYzMlcV5x25PJQgLpiSWp2ampBalFMH1MHJxSDUzW068ozD7P8uNpT8KHWZMWzj7v
        mnP/eq2KUbWghQi7n2Gwy/rw5P1b3ge72hv9mzNV6VfokQsHNxruWupQ8GzX6ogr3qVqassq
        zC4ILxZ6FJd5VENv+aX7zr8Yt6+tnzr7oMKcV0dKtVjKzx0Xurh877u+sNP53xO7VTb2iKjf
        3VCTbx6l2TZho1isVsaXRuNYQ7GJk/V1Z+jsn6+/ZvUbxag+p8Kd9pmLZV5ekKnZzNLH9vXn
        2i4FhQczORaGPKvxPTKHpdCPcca1S/tWzguc3LQs7pi+yKeZShXTOu84Hqwu3TZzCkuJkdu2
        xqSFG/8LZHNki4slT5jY6vJNNPvmtR5BKw1+87MT78y742WjxFKckWioxVxUnAgAAqDZwQAE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSvO7fVIYUgxNb5CxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZ53pPsBa8kq/Ye2gTawPj
        eckuRk4OCQETiW9zH7N3MXJxCAnsYJS42vuGFSIhKXF2+SOgBAeQLSxx+HAxRM0PRonuU98Y
        QWrYBDQk9lxsYAOxRQSKJS4cWMwCYjMLqEk8WLWRHcQWFoiTeLn8N9gcFgFViQWbZUHCvAJW
        EjtfT2KBWCUv0f3vD5jNKWAt8WZyF5gtBFQz/dU+Foh6QYmTM59AjZeXaN46m3kCo8AsJKlZ
        SFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEh6WW1g7GPas+6B1iZOJgPMQo
        wcGsJMK78PafZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqYipqaxBJ9tv/t+vznCd+hnoWTf/mez35leT5z/f8X2d9Y59WbqBXPWZFz5cey0I33Z9tn
        WnmnJshvPyZYpFzm/DjEabJdiP08xbyHLs+PysWfW2z9bWFL5IIVy8ItbZlF8+5n/V7wauVD
        7s36vQZ8io3lnIw7I44uNnaqZVBkF/8nqFIXcOeIyq8qvq/ZJa8ML8rxzlz/mf3bj7RPe6sn
        HJHK+bMjUfC/9/SfDf6HP7vwz+H4uKApqi+AuWCrEJNtg+WOxsll15MtG89GfNGwt/7ofLMg
        VHl3ffnxyNcN9xgfbOq6VpnCvDCKebnJdCmXqw8nMbicW3VbjamRm1lqwdKNpbmzf+73f9PD
        NJFFiaU4I9FQi7moOBEA8CS2sLoCAAA=
X-CMS-MailID: 20230302090149epcas1p2bad39de9aa367644cda3ffcb4dd4a612
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p2bad39de9aa367644cda3ffcb4dd4a612
References: <20230302090143.46678-1-bw365.lee@samsung.com>
        <CGME20230302090149epcas1p2bad39de9aa367644cda3ffcb4dd4a612@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cable allocation part is functionalized from extcon_dev_register.

Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 108 +++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 46 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index adcf01132f70..49605e96bedd 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1070,6 +1070,63 @@ void extcon_dev_free(struct extcon_dev *edev)
 }
 EXPORT_SYMBOL_GPL(extcon_dev_free);
 
+/**
+ * extcon_alloc_cables() - alloc the cables for extcon device
+ * @edev:	extcon device which has cables
+ *
+ * Returns 0 if success or error number if fail.
+ */
+static int extcon_alloc_cables(struct extcon_dev *edev)
+{
+	int index;
+	char *str;
+	struct extcon_cable *cable;
+
+	if (!edev->max_supported)
+		return 0;
+
+	edev->cables = kcalloc(edev->max_supported,
+			       sizeof(struct extcon_cable),
+			       GFP_KERNEL);
+	if (!edev->cables)
+		return -ENOMEM;
+
+	for (index = 0; index < edev->max_supported; index++) {
+		cable = &edev->cables[index];
+
+		str = kasprintf(GFP_KERNEL, "cable.%d", index);
+		if (!str) {
+			for (index--; index >= 0; index--) {
+				cable = &edev->cables[index];
+				kfree(cable->attr_g.name);
+			}
+
+			kfree(edev->cables);
+			return -ENOMEM;
+		}
+
+		cable->edev = edev;
+		cable->cable_index = index;
+		cable->attrs[0] = &cable->attr_name.attr;
+		cable->attrs[1] = &cable->attr_state.attr;
+		cable->attrs[2] = NULL;
+		cable->attr_g.name = str;
+		cable->attr_g.attrs = cable->attrs;
+
+		sysfs_attr_init(&cable->attr_name.attr);
+		cable->attr_name.attr.name = "name";
+		cable->attr_name.attr.mode = 0444;
+		cable->attr_name.show = cable_name_show;
+
+		sysfs_attr_init(&cable->attr_state.attr);
+		cable->attr_state.attr.name = "state";
+		cable->attr_state.attr.mode = 0444;
+		cable->attr_state.show = cable_state_show;
+	}
+
+	return 0;
+}
+
 /**
  * extcon_dev_register() - Register an new extcon device
  * @edev:	the extcon device to be registered
@@ -1117,50 +1174,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	dev_set_name(&edev->dev, "extcon%lu",
 			(unsigned long)atomic_inc_return(&edev_no));
 
-	if (edev->max_supported) {
-		char *str;
-		struct extcon_cable *cable;
-
-		edev->cables = kcalloc(edev->max_supported,
-				       sizeof(struct extcon_cable),
-				       GFP_KERNEL);
-		if (!edev->cables) {
-			ret = -ENOMEM;
-			goto err_sysfs_alloc;
-		}
-		for (index = 0; index < edev->max_supported; index++) {
-			cable = &edev->cables[index];
-
-			str = kasprintf(GFP_KERNEL, "cable.%d", index);
-			if (!str) {
-				for (index--; index >= 0; index--) {
-					cable = &edev->cables[index];
-					kfree(cable->attr_g.name);
-				}
-				ret = -ENOMEM;
-
-				goto err_alloc_cables;
-			}
-
-			cable->edev = edev;
-			cable->cable_index = index;
-			cable->attrs[0] = &cable->attr_name.attr;
-			cable->attrs[1] = &cable->attr_state.attr;
-			cable->attrs[2] = NULL;
-			cable->attr_g.name = str;
-			cable->attr_g.attrs = cable->attrs;
-
-			sysfs_attr_init(&cable->attr_name.attr);
-			cable->attr_name.attr.name = "name";
-			cable->attr_name.attr.mode = 0444;
-			cable->attr_name.show = cable_name_show;
-
-			sysfs_attr_init(&cable->attr_state.attr);
-			cable->attr_state.attr.name = "state";
-			cable->attr_state.attr.mode = 0444;
-			cable->attr_state.show = cable_state_show;
-		}
-	}
+	ret = extcon_alloc_cables(edev);
+	if (ret < 0)
+		goto err_alloc_cables;
 
 	if (edev->max_supported && edev->mutually_exclusive) {
 		char *name;
@@ -1279,10 +1295,10 @@ int extcon_dev_register(struct extcon_dev *edev)
 err_muex:
 	for (index = 0; index < edev->max_supported; index++)
 		kfree(edev->cables[index].attr_g.name);
-err_alloc_cables:
 	if (edev->max_supported)
 		kfree(edev->cables);
-err_sysfs_alloc:
+err_alloc_cables:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_dev_register);
-- 
2.35.1

