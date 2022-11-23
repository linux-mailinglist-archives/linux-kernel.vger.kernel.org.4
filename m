Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB86363C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiKWPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiKWPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:33:10 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2038.outbound.protection.outlook.com [40.92.98.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292027DD3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:33:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N66sk8YHeEj8YE01tzIOywzP+wRhr9ErETIV458x5blYog9CmXa3vgyaM9T0O6XowS7ogKuqyKydOiRlEcpH72HRdAuHFiXRs0oMRdWpKsgkQXgLrg4Ejoryr4za6sm26Kd3mCFE2L1HUrVisy1AOZ8oq6zn6BYv83Dis/1krSRA8EUTlYUgJi/aDZeMhHoVWCHEvLcMjx8XHKyhang7mfkhqe1YWP+QbcM0R7wuCLv9FKYA2XAZv7OdKfyc6Hf4/yp/9wltGXqsAdyvH3JOU1ttWjUE8BhbZwGYP6ia5lkpl3sWnpUB+JOkSwNbG9DVRziTij5hIkO0FF7UY05Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtYx2dsehvqKOTIqH+aLUlreoNGJsh0MhM83FypMTpA=;
 b=bTyrcM0ggGaUS8yeg/gqEQCOHRl+//1GGvsmg8Dj8ENei2p9RNLcD3L6Jx+FbZhHrruGepbvh7snYJoddxZFD0WFNTRElvova12AvRJJiMgx0DDK3x3t8H4UW/SJfHYZEfeKCfbuwvjs1fFajjKSGHpNhamFA9/xoHuSJ+tSAbY/gZIR36Ncq2rSNNTBrM1yXV96mTnzQ3K25srdixkkHw9I0CPM7MHhDHfeaYYNYyqFd/jpMZfIz7Y0EbYKAMcqhUkSw3O9/XB+L6rAmykg64s1rS76EJZ3ajxM5lUZw+iMndGF4NHyRS7VCdo/S3JvIlfj+741wdU3HVThmeki/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtYx2dsehvqKOTIqH+aLUlreoNGJsh0MhM83FypMTpA=;
 b=GHj91/uiyJkmWIHfzOUyVvTfvjb1TJXeEOG1i1TAS2UDwNEErHf+DEHXk2KRFq7OrcU3uCDIhUJN1iOkdF0lEsjsdc9z5zfip91sokKzKDDzZxeftShA1Sv5JdhoXP9U67d4OAOOZNEAEZO5Pw3RJCTyhKJivzZa5KnDKZu6qrE7YTjQit0ORTTGY60pADnPQA/f1tBspV7+KR0vrNTdJfWOcUH002VNglVGVnPlzH6tDTYk6QdjtEKF2Fy/hwAN+QFgIaJeVc7GEoxeUL+K+OouegLN0m0z+lbOB0ymkowKy/oBInYfyaSLTBLRrav5X7YSzZGJXmmqIWHdEwD00Q==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB2382.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:188::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 15:33:05 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:33:05 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] virtio: sanity check on callback of virtio drivers
Date:   Wed, 23 Nov 2022 23:32:27 +0800
Message-ID: <TYCP286MB23234D3251765359630AD72ECA0C9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [QZCILqdR4ZhvN9kKXoXXD1cXeci6AiVS]
X-ClientProxiedBy: TYAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:404:15::23) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221123153227.627460-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB2382:EE_
X-MS-Office365-Filtering-Correlation-Id: cb987214-7016-4782-65b1-08dacd680406
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvsNNDSScp0ukZGcW9c5unyOC174Q5NUXaIe/Qnq3KwSn/xK7gUE0fPFVbqvN7AsSstn31NHfqcuR+6KIJgpdW7QvoEW0XSnttJYqd7stlgpkHbWRusZTDG4IG20clkN8roj8dhzkDjyF+7LaQwqoxbKovxAMAmFqnx/IBlXLRHFKsANj6iKKISEqNYbBM4R+5EwcmgIAz8ayrbWE+4fW61wZrJ6ifEEln3OyMoaaRrjit6SZoXeaN0aPfKmDz0LRTG/ufmVu4TMnlOxw7DvFDEJY5CCXPq4pw7NHM50ps9QBdOe8x9JEm1hPJTZCho7/RVsvOHgNwO3FxiLCC3X/Xq04/Cnhih+WQODEwD95rCcB73tjAQxaEHElbwWlOVXT45jyxae4EmMU1XEYEltbJLYx567xp8lzoCDiyWnPn17hnsMXSJt41miX+VZm3tVzUziLrHwUtKsdJ2+mnVcMmLYBnlaaHVLRHu4ZrQPfrR6GvLSYyKcXHfkGrvIeknJPKDxfqU7VFZjgAi3L8HqSgIY9CRgwFBHDHQKD77mdt3VtI9tRmOJKtH6jaJa5DCh1P+IzOKOIapzUfl7rZe5K8Eg0gr00L0wgr9q7CU2hNO6wgtAfT5suYKkqSnSr2Qy5a8nckqzV4KDAXCDCTs70uNuxynodWuHGJPKdnXpjxnaLxxkNtg+evehidxmJVcgJvpfPYvTiykqJPPMcx6KB97tmnD2pjlGRuJw7uXQB4z5iWG2afCk66ekS2bgR/L+03Y=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyYDK1w5abFZIXwe0DwD4GQVCAI9QR/a+oOKcChdSucUvCIDRrvK83Rzsz01ayE7glBks03unh+Ouletb9ZtotOw0MEjGbhPXnryWWrBvLp34Kiz25cHBGIi7nUNnbViTEVuWPgMqFVJeAk0Q9fB8d2e4Q4QAtQOtEt+nd2ZAFl4D/Y0JtFI0awzQoOz0WfD1zHBmy3CKORV7NhnYtHi28SA5eWOu7RIiMIstE1to9yqOfdqGge/W9bPJoZX7zg7SbAK7Qy1zoX8uthr0LJQuVjzi44xibMBQh6OyCOt84GqnPw5np57L/MQV+ihiAVhnr56AwKBJP3RE7TrKy5ikmCQbhT7oCosm7/xoU43iW6UcjPvT1Haaa7JSNPEKduUjUL1tTBiR+l6KJKo8ryVNYL71nPL7OD+P7JojZhjqmVRTouexaB1fFSrdIcQCkB8Mkh1eQJby5iK2DQQbpqxrssPJz1lBVxmut7VS5EK32hgPeUgSBdRtyF1s+mYFdbEriNtx0vDarBizCSv5egHRg8tXOv3KUUjcsw9/BGG0Abm1zSAwLgYUOW5NDS9GIX+oZz0N4MURnPqtz1yUuhWI4MpTOdrfFVHSK59UeM/g+6itdVgvyn2Xu0zY8CbF/lOs9uhqu3j5qZ2uKMTH9CCiA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSOyuOBnV3YYpAuMOi2rHhMSnstQbJdVN0W0MCUQC72eqV3yBH9vrpdjlHaH?=
 =?us-ascii?Q?4CEC8LRVXYh7rCXUfPcNpXWlzCk+/snqxbURJhbrKS8ZLTWlEgx7NCE+w3cU?=
 =?us-ascii?Q?W6BZPIIPLHx/T2ywxguwRXuvHAR1Ywuq48+lIa/Q7dWnHbpwyrtsc/wUpyvR?=
 =?us-ascii?Q?cMHVAG94Kjc32vTReRNRfz7SjJ4LpCHv2jNyzkTSPJOD3hoMb8pwakkjv/j3?=
 =?us-ascii?Q?QKCfcY6cXquaM+rCnoFh9uimxtJ16qY7Wwq6Yu0rkAmaIl572n8URttNI0V/?=
 =?us-ascii?Q?siqKrmCP2ksgVhApOXjCxWxKNp82GJ6wiZevw47dU4jUINea79GSpCpysiJ+?=
 =?us-ascii?Q?BmwjZamzJp6lXH0vxL4MJGVNA1UHWq/W7WMwwY7mdX96SmiHx15cahVYvRwT?=
 =?us-ascii?Q?1YVYj/txPYs0shR324XRJQjVutLyCh+MAL+TkD1BA357CQ/bh7V0mh3VwzCx?=
 =?us-ascii?Q?tQXYJyCy5C6HpysOJE2wGFeSaw0psj8Oi6JLnYO0TzukY4sNkZLDfichd/BA?=
 =?us-ascii?Q?HC+oQ8n+ja64H3sWisWAyA0aUGEgFnQte681titKss00ns6+NG10Sj9zjiz2?=
 =?us-ascii?Q?4F+6CtlZ0LSyJFSvNvrUHkMGKcjmsEfIVBsP1wqMH7j1J1l6mBM+fgonyxou?=
 =?us-ascii?Q?Ydooxjbp1AIUrGngKJ3mbjR/Jj6+ARkE7yeTqep10iO2WV9xfYSDY5GG6Rdp?=
 =?us-ascii?Q?McERTqhdd3wJrknoTqfLGcUHlCMU/0BxLBiFgqzwzC7+lvR3ANCHi8aYnRAa?=
 =?us-ascii?Q?dyHnXhn/Fhd1dXWiwO+nOaXv2enm/mHwAm/Ttakh8SOXSNeenzoch37k0Jde?=
 =?us-ascii?Q?uXlkAM767YX6qD7TUnyxUUXQxywDgb8HAn1uuA+W4I9muhvq3oGdfLfp9NlM?=
 =?us-ascii?Q?jdJcxbxxLjeiwwjVZC1GG+LQvYuP3p6gb+xfhhDj7SIrn+eZ2/a7m18nvN5O?=
 =?us-ascii?Q?M1DM8NSvHqg5e8WDoHs2NZ9soDCFt/1dYy6gNNIp/1QY+61Ql/R3lQBZpFOI?=
 =?us-ascii?Q?QJHmMsAijR3jwvBDXc+8x+ryqyLauknAKCI4cs4x5T6LofM3bwNvcfbiklgy?=
 =?us-ascii?Q?K5rEfCXyZ2sqsv+WXHmilCvIy8IKG7COWiazwszx1+MV9mLHlYaQ/nFIH3AR?=
 =?us-ascii?Q?QS0h5HQy8VT2TR88CXGYbt6QDSiTsXJGO9cV1iDZFF0OwFl7ZR0yhQY3YAPj?=
 =?us-ascii?Q?ueUEzYKyOGnRqxqFG30dUZQSrR5uDUZ2YzDJcRqRcqUXU3eN6HL6f9GQwNE5?=
 =?us-ascii?Q?2Zy/Ns4/LEbHwXsjmmctVfLxtcK++XouwzvVlz4hfw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb987214-7016-4782-65b1-08dacd680406
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:33:05.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit includes changes below:

1 Since register_virtio_driver doesn't force probe & remove
  to be mandatory callback, so it's caller's job to make the
  sanity check before invocation.

2 Replace sprintf with sysfs_emit or its variants for their
  built-in PAGE_SIZE awareness.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 drivers/virtio/virtio.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 828ced060742..e391a8dff333 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -15,7 +15,7 @@ static ssize_t device_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "0x%04x\n", dev->id.device);
+	return sysfs_emit(buf, "0x%04x\n", dev->id.device);
 }
 static DEVICE_ATTR_RO(device);
 
@@ -23,7 +23,7 @@ static ssize_t vendor_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "0x%04x\n", dev->id.vendor);
+	return sysfs_emit(buf, "0x%04x\n", dev->id.vendor);
 }
 static DEVICE_ATTR_RO(vendor);
 
@@ -31,7 +31,7 @@ static ssize_t status_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "0x%08x\n", dev->config->get_status(dev));
+	return sysfs_emit(buf, "0x%08x\n", dev->config->get_status(dev));
 }
 static DEVICE_ATTR_RO(status);
 
@@ -39,7 +39,7 @@ static ssize_t modalias_show(struct device *_d,
 			     struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "virtio:d%08Xv%08X\n",
+	return sysfs_emit(buf, "virtio:d%08Xv%08X\n",
 		       dev->id.device, dev->id.vendor);
 }
 static DEVICE_ATTR_RO(modalias);
@@ -54,9 +54,9 @@ static ssize_t features_show(struct device *_d,
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
 	for (i = 0; i < sizeof(dev->features)*8; i++)
-		len += sprintf(buf+len, "%c",
+		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
-	len += sprintf(buf+len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 static DEVICE_ATTR_RO(features);
@@ -302,9 +302,11 @@ static int virtio_dev_probe(struct device *_d)
 	if (err)
 		goto err;
 
-	err = drv->probe(dev);
-	if (err)
-		goto err;
+	if (drv->probe) {
+		err = drv->probe(dev);
+		if (err)
+			goto err;
+	}
 
 	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
 	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
@@ -329,7 +331,8 @@ static void virtio_dev_remove(struct device *_d)
 
 	virtio_config_disable(dev);
 
-	drv->remove(dev);
+	if (drv->remove)
+		drv->remove(dev);
 
 	/* Driver should have reset device. */
 	WARN_ON_ONCE(dev->config->get_status(dev));
-- 
2.25.1

