Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D035727C90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjFHKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFHKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:17:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8BB1FE9;
        Thu,  8 Jun 2023 03:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPaq747JkNeMopnc0SjJ0kUeNFgOTDVBfO0KORejzRB0y8UjOAj3yK9POtD4jVtqS4YWUBDHoYK9DhN3vxFdHcnW9eCYpKJFoBqE3VFVI4nvLuK2u9YUYjPpW1doAoI9a9mJ8yQ1GsSuClFT9AnWjB/PQr73HDmX25gHoJq5lka+mmgm30eSQLrl2AudZuM1emxH63OlHm4k18avi+p/InCpj52EQapw1ASS9gNEhjgUsF3eH5ANvplNb6hNEtkYNsfeRO2Y9T+E2QPKJ0jAqHgO3igm/2hgKP0lOQxm/cxwjXdPh9tc4s46cAdArjro+d0tQXuzDTSMbOmUi6KcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFpzV2LhUr2j88hXBSvVs00EoHLqU6C4ERRuiAIjjno=;
 b=gNl8g8CD33C+O4gArAKVM1x8TZBX3OBrxVHpchWELZqdKfDxIEpHFVXAQzkXXezazfDZEUKBpGfiJs2xnfqT/qfLKrRdrqfDQerRBnqBvyBQgXa8sz94IAI85y7CmdSSLPrn5DcF4hxsCYFZcKgsBCm5NHj/htqTLUZZ3DgR57S3aEGnOZVdv+S4QLOAZFpNVuwuHhNBVy/tyD/9dwG6icEHGARuMAc0skPgVSVR9gNRf6DyaRvT62FVxejb4KGhJ3SiEvq6wt1rTZNt/wAcFdQQqb1VtOJdo4if+wVYOVUsyccnsdS32X4ZxvFjASdwr7hrqKqveCYwmcgG+KiqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFpzV2LhUr2j88hXBSvVs00EoHLqU6C4ERRuiAIjjno=;
 b=C5CyWhzYwfcn+X8ulW1vWLAc0/nXQH+cVS+tKmhI2THB87XqDwTl1dV/sws01jFypjRyb3duGNCHODzpDTarvnA+XDExcXopGq83JaLlVImaw+8uh3hBriPkg+kgNGl5b/T1WK+v6SGNODeNfxhMdlVWv08nu8bB7KSpLlERaEiOq3xxA1BcAgf+7RM79a96FxVu8nSccPMGIncnjlkipw4k6eyfUsFzYRkKrzyWApi+Klz1/622hyefWZVJ/hxbKSxbd2GNmLUbf1+FbH/jHT2OgSURoGlV0bXZL484TMtZ6sKlFPwI7V1fDve4cq1spPHWSNSSaPIzwsEnuhlhlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by PSAPR06MB4456.apcprd06.prod.outlook.com (2603:1096:301:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 10:16:56 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 10:16:55 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
Date:   Thu,  8 Jun 2023 18:16:40 +0800
Message-Id: <20230608101642.40086-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0049.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::13) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|PSAPR06MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d203a8-2ae0-4f74-c7fe-08db68097c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVCh5YqHLozSKg7/JvsvSYno7glaof0l1XRMXdTDJCFv+mi97ZlvdXMCpIj8nIhkSzQzsRbeunf2kY7/XUmLYOoklPdqYEKQ31djkEWMc0BUwCH0/ImFwJjpcYOesO2vMmsCrvltdf8PFT2eYRfEyCiKmlbh/2GbPKF7YY3r59+lfbIx5cDaL36jq0qZQzMSzEnbAqWNLHOJdeq0XC+sIS6hz+bavmGVm22NkZknWe/SD9ApMVhlPG4D/hTIbPXlg54+22Moo3K/PcLysKn36DXQeawTY4mU+Mkh6lpusJzQWMiOwYxE9lGd7hEW6mHshWR1VBM9YR40t6gpW1k/w7XdNKAQD+q7lgvZGMJmbUWgf4Fbi49LcqPuDAkozA+S6OuvMFc17bGD+GAoYK+/iIGcMDjnA8GwkCwm5nc0Gn0Ovgv8ukAdp5hGTbSTYgNvgJ+AHuB38vLqFApqMJIZlTHV9d8du5JjN08IOV3M2PSeBlsT1Kmi1mSvTTx6NWz9ZjrfeQKuviUaj1R3Jip4mvRzj9/PCiUrpaHGLoPCTzrEFeK+QEOrnZXiKIitl5sJlakG9bCBLqbYdb2lYa88+jYYF7ACmhlbkNokFq6CaRKqQolFFBQxFS81BCKJXS3grJrYZihWVDN51NZNjXENGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(366004)(396003)(376002)(451199021)(8676002)(107886003)(8936002)(110136005)(478600001)(6666004)(52116002)(5660300002)(41300700001)(6486002)(316002)(26005)(1076003)(7416002)(186003)(6506007)(66556008)(66946007)(6512007)(4326008)(66476007)(2616005)(2906002)(921005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UA6b+RWyBsEkYOwh5EzuZF+tw/Okogcq9cL5PcLQPnG8ecuy6XlP0WnJlLmk?=
 =?us-ascii?Q?vfT8SbEhhZVJjfgrvCXiw32MBAcM5fjFbJtYPpxj6VOnqRbS7chgwSHkdc3J?=
 =?us-ascii?Q?13gB3c7PIBXafQg/QFV4ZFmSEs+y//RRHLYIL+FELsDjfsZPXMLW47rmZkOI?=
 =?us-ascii?Q?KGMgTrOrPlGWZo9nYyYQIIpNBkmgb/EjEXtfklVqqosAIAPDcDslNfB34C3Z?=
 =?us-ascii?Q?frZW5shKgHfmlUiKbwUE3/GVgm0/5tSSxBiAV3Vh0tkNrDXexa8ndv2PIIW7?=
 =?us-ascii?Q?KWNO1Vi6iYuTd7Cs8TZkUVKXrSJk75BPKcAI8Zt2t+4bvVdZzfxhptrC2MM9?=
 =?us-ascii?Q?FphRenyRngiMWFCbJkd3G24isc6GjH9n9UgEc/RqSnppZUpIwAVLnrpY7BUS?=
 =?us-ascii?Q?VmPTgLcjg8O2Lve16xCyhEfZh/h6aiiBooWfPB979+YwMtFgZnWv5FrBwjiN?=
 =?us-ascii?Q?0OE3zNNDgpQsOx7jJ0BFO2rY9q/zBESAB7IA4I0QqGAFrLTlAgWsERA/r6ol?=
 =?us-ascii?Q?XxmC7lXFKtzxW7B/nRxtFULYgX1+W4UDfBNeWDmB/GCXjqvFXV5kfF7S//4I?=
 =?us-ascii?Q?Iv8CRn3hlJVbjuasnbo6OxtxKk0j7VA8lLLUH1xh2FGBfXW35lO+2/S1PCCB?=
 =?us-ascii?Q?CG8Zp94lmSLshWx8XnNCRhFq7a2gKcx83BMIgJ3UsXgixM97F3i8deP4+aZ5?=
 =?us-ascii?Q?cx5A6gnPJ+e8Sa3inGMJhoSJulz2EHJfatrzFK/kgIUDpslDPT19CuaEtsiI?=
 =?us-ascii?Q?MTzmNrE09+nJzA5dB6DNjDZjQ9wNKbc8A8UXikBZG/73ptw3v1qGjo5QB5Zh?=
 =?us-ascii?Q?TQL6q4rh8osDwfFYEMh0o7hukPBpDtbwt4Nz6SqtHixbNFW+CusxNnPYRhYW?=
 =?us-ascii?Q?b59HzUaWxSTEA8rtbctNtO6ckj3yomXRILoLuHmwVI05oAtYAdscwaQYgwgc?=
 =?us-ascii?Q?OG5+BAIpn+oJVmIWhi51xe55vYrSWOtyUf/Q1gPUjRyDTv2xwKf2w4MccI71?=
 =?us-ascii?Q?w8sG96PWx1jKnEn4xg+EzG3irHunMPYj2kft5Cn4EDKTo8WEKJLhU6+RKKHT?=
 =?us-ascii?Q?dCptdKi91Rfpy5ZMV5FDj9fBgFIR/aQoWTj7+RP3/t0NcIy6x1lsqozizDBo?=
 =?us-ascii?Q?6IELYa6UV9dP1T3Hzrhf6/uSj50IrGDNA435s0nicnIfKhyMbeS1xumYAokX?=
 =?us-ascii?Q?CBeuD1hPNSkgdvKYClaFmAojGWEVPU5L2ABZ5R/NAebFcPjNWdVVCvn6P5U1?=
 =?us-ascii?Q?wVR0TtrKVp1AFgmcTI08ww0pN+CNa7F7QoVyCghb3nYLHp0IyzTAeDoQVXhY?=
 =?us-ascii?Q?5OzbMTON6XLRHXa4J53iZnrQlkfDf+ogo5tyU++s8kiW76YleQPcFDyJg2Y2?=
 =?us-ascii?Q?3uTM/mr6+K3A72f3ySwf2IJLMYLrio3VrZqpz72wLHUZIZ061TTU6TvlfnZp?=
 =?us-ascii?Q?SRfSslbAeuNGEIjgKWw2FZPctESbn4HyK+zOssCsRzxZjV49fgYqhAkBXNWf?=
 =?us-ascii?Q?10ZSousl/vF0ft4oKgi++EnXlfQrvq8H5yLaxLVtD09o2zy9BxXOR2b7hs+w?=
 =?us-ascii?Q?GzULS8gezDEz7rDWfSKkjmmVBS48RDUAnxs5Vtgw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d203a8-2ae0-4f74-c7fe-08db68097c81
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 10:16:55.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlX1WCgkgRF0uEyENakPCS/Pyqs+mFBgIG8yGypSOVeZEj9wA/jcqwezsqe6F8295y6h2ldRRLQN+2jGF1+tdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three flags that control Write Booster Feature:

    1. WB ON/OFF
    2. WB Hibern Flush ON/OFF (implicitly)
    3. WB Flush ON/OFF (explicit)

In the case of "Hibern Flush", one of the conditions for flush WB buffer is
that avail_wb_buff < wb_flush_threshold.

As we know, different users have different requirements for power
consumption and performance. Therefore, we need the ability to manually
set wb_flush_threshold, so that users can easily and flexibly adjust
the wb_flush_threshold value, thereby achieving a balance between power
consumption and performance.

So the sysfs attribute that controls this is necessary.

The meaning of wb_flush_threshold is the percentage of WB's total size,
such as 1 representing 10%, 2 representing 20%, and so on.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/ufs/core/ufs-sysfs.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index cdf3d5f2b77b..679f65dc4cab
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -298,6 +298,41 @@ static ssize_t enable_wb_buf_flush_store(struct device *dev,
 	return res < 0 ? res : count;
 }
 
+static ssize_t wb_flush_threshold_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->vps->wb_flush_threshold);
+}
+
+static ssize_t wb_flush_threshold_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int wb_flush_threshold;
+
+	if (!ufshcd_is_wb_allowed(hba)) {
+		dev_warn(dev, "It is not allowed to configure WB buf flush threshold!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (kstrtouint(buf, 0, &wb_flush_threshold))
+		return -EINVAL;
+
+	/* The range of values for wb_flush_threshold is (0,10] */
+	if (wb_flush_threshold <= 0 || wb_flush_threshold > 10) {
+		dev_err(dev, "The value of wb_flush_threshold is invalid!\n");
+		return -EINVAL;
+	}
+
+	hba->vps->wb_flush_threshold = wb_flush_threshold;
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -307,6 +342,7 @@ static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
+static DEVICE_ATTR_RW(wb_flush_threshold);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -318,6 +354,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
+	&dev_attr_wb_flush_threshold.attr,
 	NULL
 };
 
-- 
2.39.0

