Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECDE5FAA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJKCar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJKCam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:30:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184B2E9FD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLnys93CT8l+0Kin1LIq8XTiRjeoDbYtnpFPU79VY5LS7iiBRydGOMmzpI9wX24sBy6oVcsejzf/dtgl+ImnN2u+U0kmKlOcwQWswz1RFfxTOaisq8Lf8fv2iv7mP+7Jt2ALIV8tdKQyMPm4QCHGppRlf2XBCpLVHvIaWqYexIeVyggsPyytc3G1IZqCry3Dl8G4a33UMvbZfw7g603lSuWV+Njo2ePgX/MY3CxZWtZyNVOu1GaBmklA5GhICqwD80roFidwpCzrSrk5Qa8HrSGE0AOP9ioiC8lzslVqDI/MDowYRiQESl7nlv8QQ6m6LEyKbS/M3bi/Q04hSHtBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH8A+1gqy1jb3HGugI28RnU1rHFaW9kH6j/2+B4d1Cs=;
 b=m5o/nOVm/yK0faxYyjlOv8VYOa4eG2WGc7fIyADaNERzhqhjhF8aFNkOZEc9of3BqsR3dCFnIdBG1bsvfm50PHY6jVW0nPELeKXxjp8o82HYS65GA0Sel0prV2+j0GVCZxiJ1NxF32ZRN8qcsGQds07q/U55KuF7vIacv1OYOYscX5Kv2VuipqHH8uiUBWP4ZxT63iDaP/0ZeSxd4JrCZnISkKWbyLp715jIb9c/bY/Rdufrs/t8y5UE04y45OFeBfzVMhLNOmxh7vYzmfV5tMracaBQVLnlC+jJHXVjXLiadqf1OZb2Boo44UPT2KkCvwWmDJw1u1iZLootlSW1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH8A+1gqy1jb3HGugI28RnU1rHFaW9kH6j/2+B4d1Cs=;
 b=F4m3eajcG3PlRC8IG0Wl2RgKf9JXcWDTLMf0TMdL16librEwk/pNPNQChwoRmR3f40+pTGJqux/9Q/NVW8wk5FENiRYmFVmlNBVVCL6BgT3f3exSmO0VFtq9uvtWk3OD3CY0rOqPeIqyrrPhXXzfoyS/4s2UPgKzrRU3OqyftC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 PH0PR01MB6438.prod.exchangelabs.com (2603:10b6:510:1e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Tue, 11 Oct 2022 02:30:37 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::e591:47a2:a605:5f81]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::e591:47a2:a605:5f81%6]) with mapi id 15.20.5676.028; Tue, 11 Oct 2022
 02:30:36 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: [PATCH v2] char: misc: Increase the maximum number of dynamic misc devices to 1048448
Date:   Mon, 10 Oct 2022 19:30:33 -0700
Message-Id: <20221011023034.155265-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:610:e5::32) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|PH0PR01MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2abb7b-c6e8-458a-db9c-08daab30946f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVf/ONG7vGuavbv/gKQlf61YNcKjfG2tqwkN9TTHzuaAOius3wmu9dUqTJ8DmhVqE21MKaU99tq9/4w4nH3kTfFNP4tH1i6bWddwg3OATSzZJxr1H6h8k0mxmXMK0i+2JU6P53EW7kjknF/27JUzSbFPkd4x+Cv1mNeq9ngvBdWN9pv3q8IOwlIaqoNvNoK8qfxjClF6MmFDeftoDV5xS0BAcfsc2Rlirb8pay1QWJ6ya4/XC0hswgbaqAH1VwHXumUdtDvLtvfpWTPz9qv9EjPpfgmDbnuj0bd2BM0RnLcPkAxHxRZiYRnjqaieRQ8hY5VPNSgzm3IVd7M9NyChYNvPR0vnUrltEXdZDqly1mttlOE4PBghp+6SiQzxgnjLuEbfl6c2xiRuN/wWoCvCXLJImEoBnfQVdS/c1CBfqI5+7vQ+JRAzytJJ48Pt1M/dQO2EDl8YcQ51i7DURsHTEI4zNAOuYV2JMsuMuIMby3bjCL6lDoW80/RbXCLtPCns8AKvnsiy+PZgoz7IAsJJnl8/TxDVAQi6fZKhh9xmqD+NQC267MCinCLauw91C0fvVr1jjHztWYyufZ00jUsy6EOWEa1qHbMx61VgiPgZUuvXH119c8+miApsZ0FD2jwc8XhY2WCTM5TKzWbNIOSpphEdmykwsAs0FtzPSt8PTjNmzFtI1XwaC39ROZnRGoqBGbA/UuMt5t9vGyO7bs0ezxgI4luIVMbI9uCg8ZJylX6fR1SUsS8Oo5qamZArVrxmRbcqSAlUPWM9qXgxjHS0FJsBwd0U2bcTlJJx6Pg4ZKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(451199015)(66476007)(38100700002)(66556008)(38350700002)(4326008)(316002)(66946007)(86362001)(8676002)(54906003)(2906002)(6512007)(41300700001)(8936002)(5660300002)(107886003)(110136005)(186003)(83380400001)(1076003)(2616005)(6486002)(6666004)(478600001)(26005)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hqWo5NN45SJD4mUd6YVRL3uyplFFG5gRud33GWRxvUb9q6X2R3BwFnQNweO4?=
 =?us-ascii?Q?SRy3jGvveunux6bBtuAeDC6ju2JGfmwbbo4KvGOa8pdk2r4oc+yolwH2zPaM?=
 =?us-ascii?Q?s6dJXFirnPgSFc+zRYxy4IlqL1P7NKOEEUfnzS8NqXOWiZh7VS+IYw8knR73?=
 =?us-ascii?Q?IIAfntYGGFfXyiGX833FzfZWl0Op/Ch8WE3aE6OoLNS9uX+nU4h6s5tN5NVS?=
 =?us-ascii?Q?Iu9L0rPNvd/NUfMCEmFElo5FOSRE91DLgUE7cVZ8fetKqGwRhmZtSRf8BOOM?=
 =?us-ascii?Q?MldeCNwCz2fACw7o5EtgDEKIZA3Xfc9Za9gI5r/xWYvoqdl/64TKgIcA14Tk?=
 =?us-ascii?Q?kxsTSlTZXESbmp6i9kQnynJKwWyEcXa11F77S7cLMwWaGgBtK+J2uNCxm/AD?=
 =?us-ascii?Q?/1MZQlZvLV/B+vtSu6y3pakXcMOnse/IuA+qo5D9jtcQ38ZjiaU12FthQZJs?=
 =?us-ascii?Q?+wZWhJssDPZxMCA6OCfdKER3wzoQv3bBBaUbqpfdCbIN8OvpJFAyLM23N9/G?=
 =?us-ascii?Q?JHK9U8nIPZ3HXTK7oL5mjIssYth/vOQllRzpdGlF8baKOiElk7cEhhfC+ASC?=
 =?us-ascii?Q?HO053taz43UbkRbyZf5atTYz3rMWm8ApmRrOYozBkJE8BKQqtUk1o51KfeX7?=
 =?us-ascii?Q?gulBPhSc2xzlJx/4gKWIHIQ0RRP/MOZpogik369Sl8rWg4ryOUtUnyttQ6yA?=
 =?us-ascii?Q?zScocxisWx7KeJuRPC5y47QnL6nBfy6tjZFGH/bYXyGS1rGq7UvCiysuJ4Fj?=
 =?us-ascii?Q?T6Sqjta+roFZuOtW9IeguBzJVd0tK16vU/aej9X5LMWqWpb8pabp8ufXV2PB?=
 =?us-ascii?Q?8mBVERZ11dTCojWG5MWl2IGSdKlHfhbc1pmS9kDL+ODKxjVUgtPrpDcZC93+?=
 =?us-ascii?Q?k59jAOrSahIni/c5IRt/faQ8ex8w5p6MB/18cC8D9gNgkoMtuFd8+XDgY9gd?=
 =?us-ascii?Q?+Vs9jcQAjhaO4WdG0juUMSH+wkkQntl5sAx/ZJkcQ9sxp5odr2xdf4x0J6Br?=
 =?us-ascii?Q?1sYpem+kIYcLmplNdRXqg0JUWdNnTUb/RwispTia7VQIt/Qng8PuG9OHqUNY?=
 =?us-ascii?Q?aPUNNro7lvvk/e5ypE0RtD9nIo8xaTwn1mRHJ5EJmlL7W7ZrUwgrNSCcx0LR?=
 =?us-ascii?Q?O8dEUIUxCy505JZZf1BD1V8EfKuNP+6LfK0M+JrrpSAzJPE2kNc/PCgjfpj/?=
 =?us-ascii?Q?FgOLOvUQr8+hSLyhcyyIISgIufJQCFWc3grHTw1wM0tzehT5qbC7gSTYkZEz?=
 =?us-ascii?Q?IVOZ6YjI5piBh3G7CEnPWfhvT+X0UYu1ey6Vq9YNGtfPavTB77xxRs+bEqOw?=
 =?us-ascii?Q?lWKOKERYU1AfSY5dhFqFhpKUVAEJ/h7Q7+oJ3MySFui/PEonvuec7O+0YlMg?=
 =?us-ascii?Q?1NbYa+xiWbR+olPW4w2p6R5cCj406ua8h0FlfOF9cUkBLgGraxDU9tyd3gHX?=
 =?us-ascii?Q?x8K95cw8KL/usDOlfu+wuVUBRyq0D4S4O//uYzoIVFzZ6A9Ay1GDWP13IgM8?=
 =?us-ascii?Q?R4y99XuzBevLQE1nfBykghDBv3/WUkIN7iIN0BIHllHUXcM0sC2qZh6iMJiV?=
 =?us-ascii?Q?nPNz68mkqi/j0bLex5SEUuBy8C5kiTkZojZbow+7LeAtUOqOsNJizPq71+AN?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2abb7b-c6e8-458a-db9c-08daab30946f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 02:30:36.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwn+3S3J52T7YveX65XAKCxy3q12xlMtvHdhz9EMuOSMaEGnW88SX5uq1poE/5wAS5ieVpMs43PRVD9X3tQTVYZDUBrMhQAuffROStp2xtXTsCfCkNNIXUAvJWoaE+0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6438
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AmpereOne, 128 dynamic misc devices is not enough for the per-cpu
coresight_tmc devices.  Switch the dynamic minors allocator to an ida and
add logic to allocate in the ranges [0..127] and [256..1048575], leaving
[128..255] for static misc devices.  Dynamic allocations start from 127
growing downwards and then increasing from 256, so device numbering for the
first 128 devices remain the same as before.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
Changes since v1 (https://lore.kernel.org/lkml/20220906195213.2370775-1-scott@os.amperecomputing.com/)
 - Update the commit message to better express the intent.

 drivers/char/misc.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cba19bfdc44d..05727f0daa6b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -61,7 +61,29 @@ static DEFINE_MUTEX(misc_mtx);
  * Assigned numbers, used for dynamic minors
  */
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
-static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
+static DEFINE_IDA(misc_minors_ida);
+
+static int misc_minor_alloc(void)
+{
+	int ret;
+
+	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+	if (ret >= 0) {
+		ret = DYNAMIC_MINORS - ret - 1;
+	} else {
+		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+				      MINORMASK, GFP_KERNEL);
+	}
+	return ret;
+}
+
+static void misc_minor_free(int minor)
+{
+	if (minor < DYNAMIC_MINORS)
+		ida_free(&misc_minors_ida, DYNAMIC_MINORS - minor - 1);
+	else if (minor > MISC_DYNAMIC_MINOR)
+		ida_free(&misc_minors_ida, minor);
+}
 
 #ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -183,14 +205,13 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
+		int i = misc_minor_alloc();
 
-		if (i >= DYNAMIC_MINORS) {
+		if (i < 0) {
 			err = -EBUSY;
 			goto out;
 		}
-		misc->minor = DYNAMIC_MINORS - i - 1;
-		set_bit(i, misc_minors);
+		misc->minor = i;
 	} else {
 		struct miscdevice *c;
 
@@ -209,10 +230,7 @@ int misc_register(struct miscdevice *misc)
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
 		if (is_dynamic) {
-			int i = DYNAMIC_MINORS - misc->minor - 1;
-
-			if (i < DYNAMIC_MINORS && i >= 0)
-				clear_bit(i, misc_minors);
+			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
@@ -240,16 +258,13 @@ EXPORT_SYMBOL(misc_register);
 
 void misc_deregister(struct miscdevice *misc)
 {
-	int i = DYNAMIC_MINORS - misc->minor - 1;
-
 	if (WARN_ON(list_empty(&misc->list)))
 		return;
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
-	if (i < DYNAMIC_MINORS && i >= 0)
-		clear_bit(i, misc_minors);
+	misc_minor_free(misc->minor);
 	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);
-- 
2.37.3

