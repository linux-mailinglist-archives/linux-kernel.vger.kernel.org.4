Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B51712DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbjEZThz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjEZThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:37:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB86A4;
        Fri, 26 May 2023 12:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmIxeltzujDK/5iBz3VmG2zSIzuxTbBcRmKW78aUsNbWlmudzjUJ3zfgegkFW+FDThbPtGNZ7WZtfDp8mxai1p4jcpgdGE1KZP8GYIJB0HFvFHKX0FMOgMxlzBinsroySSBl4DLF6drNJsAnFAgDKq9KMnD0Lbxs+G67ssj60gvfx0WlqM69qgk9WM8URa7dOfxti2LpasuzOJW++Qw93srmCrZZJw3MKGRnJrLaSI6MOpHF6inRzEfBC1WSjARS1Z7H8lMKYuwCoByFYQ9PrWOAb1/nr6SPmz4xQUPSu6F+vkkJUGvdasNqR4RWvQRGY40zkNh+VPY1RojC6L0DzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuaksgCimP5Q7ROwR0mfFpKBUx4te1HCFb/BXqZIE9U=;
 b=eJYofy9xiH+uojPlcyWYcz5fq2sPAC3fro3jYYo33zZeiv4+kCauyAmeNAKlfVbaYzFQDtnRXKg/U5QUOqcBHhgTwSlwjt+rwH0qHL817jCTVDoPn9qqoxEQISKpG1M5/m+/C61ByqxYWWqoMsB/b9Tb+vfmH/OYV9Jzjj5NE31H8XtwAL9DzI03qkbHwmdF5QCOn1w3mg9ZfJx+7fPlOxVqCDRewd9euIRZKCM9XSu/LlRivNDwsnoz7zGclnE0eRIOnQyTXYNwoq2/Iw9ZPoyEwgtpxEOKlGPCM0H8Gh0H269NdcpCGtHpeC81GeU2WSvYowyxTndaQJZl9LoamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuaksgCimP5Q7ROwR0mfFpKBUx4te1HCFb/BXqZIE9U=;
 b=DJSp9BOY/DUxLCxtNCIMMmyDRKX4s8iwPK2qEWYIXwEMj9CzPMH6qATTSvWNtN9hFlCYAlKCAEqPYBgNYX1EKWkQGatOihSu5aM1lL/oQpJahft4Einmt/qPd5Aj7dMsTR+WL6aQdXKIXo6lk+T5gE/c19xSUYjO44t3YfaJiME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB8182.namprd08.prod.outlook.com
 (2603:10b6:a03:431::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 26 May
 2023 19:37:34 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::c696:d0df:10ac:8071]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::c696:d0df:10ac:8071%3]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 19:37:33 +0000
Date:   Fri, 26 May 2023 14:37:30 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fred Treven <fred.treven@cirrus.com>
Cc:     Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org
Subject: Re: [PATCH 4/5] Input: cs40l26 - Load multiple coefficient files
Message-ID: <ZHEKeiDRtKQ1FnfE@nixie71>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <1685059471-9598-4-git-send-email-fred.treven@cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685059471-9598-4-git-send-email-fred.treven@cirrus.com>
X-ClientProxiedBy: SN6PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:805:ca::25) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 10158144-c7c7-48c2-7f5d-08db5e20a6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVb9yLKd0ujeqVU/9cR4CohsD16axua2A/ms1rKEGxAULarnOMAR2LiZFnhbNVWpaZECSBYq21o7EbQ791fiHIId7yE7D2fsn5ceRWMv0BWF6HRRQYF2exJnZa+n49bN0bIxXSKh+Ie/YoT7pN+hQVwDvfBFItuJ8qvdZzIHMhSburZnAxykQM5eaugWM+/oEjzBmoysi4Lda1O+6ppT9iLhnFV3IsvGgeYitfEP7dxL5RxEJ5wOR48P4leh4dML8kz7deR8QESed7Mm3WBARrLNGQCY+dQOjspd3KObp9237Y1+45iqwUMfiBIIr2jLt9467zxzNYOCr8H+lFoHTM0RPkM6b1zOQHYBhzBQfPZ1He4mxELkeiFLB4CGaS9aa1o1OasR1gNjsZ2ftL1498tPCs5RYJngAaU3391XKhQImobW2r4KIvmQqcNlT9RjXGJ2TWoPc2WG4aFxYSvTj+hTy56r9gMMtUcJ9QaenDgDD1s08/YGlc23JR/Bilsk3zrHefhStAXtlfYuY5n8EhSa6IPd5HAjtbnqCvpFCpRSBGXv5qIlak1VuYkntejw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39830400003)(366004)(396003)(346002)(376002)(451199021)(8936002)(5660300002)(8676002)(7416002)(2906002)(186003)(83380400001)(86362001)(33716001)(38100700002)(26005)(6506007)(9686003)(54906003)(478600001)(316002)(6512007)(66946007)(4326008)(66556008)(6916009)(66476007)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IlrlpJPFuHB0/EczezOIZFVIxv+GfTwHTMuMlTbaMGvh5JM7nBWoEA1bcNTf?=
 =?us-ascii?Q?9SeuRpABkuGI9xo7G+B+X+9CngmngIAGh8qobPs+4znviOzAfPQRN5/YI776?=
 =?us-ascii?Q?TEZko53JCY27ZOeEekW/ot1etPfNYrzYCAAjzwUr938D5Cps6WNKxZ6Ox3OT?=
 =?us-ascii?Q?jRO7IggAZO14dBMNn1oHJ5Y8+yVERnnUgldz1yU0+ArPt10dKDCweWDmlBgc?=
 =?us-ascii?Q?Nq+/bkLlMK3X1IWsAWr07V+OOKIij8ab/4kaZE7B0EDq248dKviyhe5p0nCu?=
 =?us-ascii?Q?XA4NkMK9g1mcW4nZRzkrtqkMNQhArhdVv1IdM87kBPRzqhTiaY/kfvpODFlT?=
 =?us-ascii?Q?FTFE6F2BO4wjn0x2ZVudoBjko+btGQVZJnhfbEOrICeEZfQkgyM78fu6eseo?=
 =?us-ascii?Q?gEKuU4d0DisDMe7AnOBcZ3tv0WisfwgwA9f0fv2PxN4wsRnee3fMYnl/PLpe?=
 =?us-ascii?Q?CbQtJyO6FnrzjjzE2jgtggVwdlXL/nwlfU0hKzlkngDDJxRa8AcUV6j4Mfjt?=
 =?us-ascii?Q?ntq79pbpOi2nLbqY0ACatUK0N7K6v8IXGtw+qFakRKjcwDaKmZYxTetVqIYp?=
 =?us-ascii?Q?XriAp2vXaG9W+XuX8QaFH3EN2kNbQcxrnYJ+rzROdYCjCpTkLkHxHkc/IjYE?=
 =?us-ascii?Q?5fXfgkaxMgsoCMzId0xo+U5ZCYfHYAOHN2txDkf3P7LHm8qHbpsCOxTWY7R6?=
 =?us-ascii?Q?ibsVyRtSZewLY5lLmWK3ucB8p9KrQ2U/i25L1PPvCtAS+H4x3ylezUnNHMLz?=
 =?us-ascii?Q?PWQKdNcird4s2T4rfs00cTgR2QQs7aeOYbHLrgYboSwYV11Ny4U3tmiuHIo9?=
 =?us-ascii?Q?QXTBrlBwtKWZ4RoHoIUKWgAxWxI31U8jMKU7uKHEGVSiY3+QE0VlKS8NxpcG?=
 =?us-ascii?Q?NxqDQrkfYVuTh67xoFkaAD2nD9LAflpX36JqRK6XxyjObIQWLJxmfkieUdE+?=
 =?us-ascii?Q?9L73yAfRsteD0o42jIpah9bTofXpxbRDc43AkVgjhdly29WCOEz1ATgOK17b?=
 =?us-ascii?Q?1my0XGke1stkmTSD82QAdFWtLL3K1CA14rn7LASQwofK9yy/Huzt6jczQQmv?=
 =?us-ascii?Q?hTC9Gd1SIY/eIuGyEaKpw1KkbsmtxBLQ+Lwzw1RKbRih4BRhFGJ9CsWyhf2/?=
 =?us-ascii?Q?4lJQc7AuHcNAE9HsMLXdcyiSjrVgQSq7x6fAThqtr3CkDHrwSD2yIzPbk1Oh?=
 =?us-ascii?Q?oUuQzxBrcWl4JNxGZcSOmCSUmj/V+zAbippAMW6k9JUFBmm7dm/+foMicVy0?=
 =?us-ascii?Q?3W61GNSgMLNLXVXgceteMHxvQgoTamdFKwJPRkwWS7wBMDx/7t97mahMoTEv?=
 =?us-ascii?Q?ObRA6mAjS7WWMOPUJjR5HERS/+NElB6sKO2NOQoPmhqUbNfjQXz1m7j81Zps?=
 =?us-ascii?Q?lEnBfZeamQRZNvq5IzTAsd90q5n42aVKjWvCgVi2S8Z95T8Ep3k4X7i6ZmA4?=
 =?us-ascii?Q?gKsHhwPMlVNBHE9T+U6puBwpBNZWVSSmwHnkKOY0Dhc0mBLUH7yKXiIQoDV5?=
 =?us-ascii?Q?RKd2QheF8DDgDQvMzGq/BlV4L5tx+3q0+oL6it3Kjb9AhIH6EXRcfjK6nr1D?=
 =?us-ascii?Q?hvPdIDbEnmz5BSbrmw+VZtmVxpirTeVFqOkmMCRh?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10158144-c7c7-48c2-7f5d-08db5e20a6ea
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 19:37:33.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz+cjpebdLuJbyfT8r8IcPkECPBTKXnFWWkc1wq/jn9F/JNBVzDEKTG03exhQsMcE09jNXKOrqVfa3lNF50X8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,

On Thu, May 25, 2023 at 07:04:30PM -0500, Fred Treven wrote:
> Enable the driver to load all necessary coefficient tuning
> files:	cs40l26.bin (wavetable)
> 	cs40l26-svc.bin (Sensorless Velocity Control)
> 	cs40l26-dvl.bin (Dynamic Voltage Limiter)
> 
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---

Thanks for sending; glad to see this series continue to move along. Just a
few notes about best practice for reviews:

1. For the purpose of mainline submission, patches 2 and 4 must be squashed,
and then come after their dependency (patch 3 in this case). Otherwise, we
end up reviewing code that subsequently disappears or changes in a subsequent
patch.

2. All patches in the same thread must have the same version number (e.g. v2).
If a patch was not present in a previous iteration, the change log can simply
say so. Speaking of which...

3. Please include a change log below the '---' so that it is clear what has
changed since the last review.

4. This is a matter of personal taste, but for a new driver that touches a
few different areas such as this, it's nice to have a cover letter to explain
the general layout and motivation. This is also a good place to put a change
log.

>  drivers/input/misc/cs40l26.c  | 31 +++++++++++++++++++++++--------
>  include/linux/input/cs40l26.h |  3 ++-
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
> index 1959438dfe31..12c29cbd4ff0 100644
> --- a/drivers/input/misc/cs40l26.c
> +++ b/drivers/input/misc/cs40l26.c
> @@ -2006,6 +2006,12 @@ static const struct cs_dsp_client_ops cs40l26_cs_dsp_client_ops = {
>  	.post_run		= cs40l26_cs_dsp_post_run,
>  };
>  
> +static struct cs_dsp_coeff_desc cs40l26_coeffs[] = {
> +	{ .coeff_firmware = NULL,	.coeff_filename = "cs40l26.bin",	.optional = false },
> +	{ .coeff_firmware = NULL,	.coeff_filename =  "cs40l26-svc.bin",	.optional = true },
> +	{ .coeff_firmware = NULL,	.coeff_filename = "cs40l26-dvl.bin",	.optional = true },
> +};
> +
>  static int cs40l26_cs_dsp_init(struct cs40l26_private *cs40l26)
>  {
>  	int error;
> @@ -2035,14 +2041,16 @@ static int cs40l26_cs_dsp_init(struct cs40l26_private *cs40l26)
>  static void cs40l26_dsp_start(struct cs40l26_private *cs40l26)
>  {
>  	struct device *dev = cs40l26->dev;
> +	int i;
>  
>  	if (cs40l26_dsp_pre_config(cs40l26))
>  		goto err_rls_fw;
>  
>  	mutex_lock(&cs40l26->lock);
>  
> -	if (cs_dsp_power_up(&cs40l26->dsp, cs40l26->wmfw, "cs40l26.wmfw",
> -				cs40l26->bin, "cs40l26.bin", "cs40l26"))
> +	if (cs_dsp_power_up_multiple(&cs40l26->dsp, cs40l26->wmfw, "cs40l26.wmfw",
> +					cs40l26_coeffs, CS40L26_NUM_COEFF_FILES,
> +					"cs40l26"))
>  		goto err_mutex;
>  
>  	if (cs40l26->dsp.fw_id != CS40L26_FW_ID) {
> @@ -2062,7 +2070,9 @@ static void cs40l26_dsp_start(struct cs40l26_private *cs40l26)
>  	mutex_unlock(&cs40l26->lock);
>  
>  err_rls_fw:
> -	release_firmware(cs40l26->bin);
> +	for (i = 0; i < CS40L26_NUM_COEFF_FILES; i++)
> +		release_firmware(cs40l26_coeffs[i].coeff_firmware);
> +
>  	release_firmware(cs40l26->wmfw);
>  
>  	cs40l26_pm_runtime_setup(cs40l26);
> @@ -2074,17 +2084,20 @@ static void cs40l26_coeff_upload(const struct firmware *bin, void *context)
>  
>  	if (!bin) {
>  		dev_err(cs40l26->dev, "Failed to request coefficient file\n");
> +		cs40l26->ncoeffs++;
>  		return;
>  	}
>  
> -	cs40l26->bin = bin;
> +	cs40l26_coeffs[cs40l26->ncoeffs++].coeff_firmware = bin;
>  
> -	cs40l26_dsp_start(cs40l26);
> +	if (cs40l26->ncoeffs == CS40L26_NUM_COEFF_FILES)
> +		cs40l26_dsp_start(cs40l26);
>  }
>  
>  static void cs40l26_fw_upload(const struct firmware *wmfw, void *context)
>  {
>  	struct cs40l26_private *cs40l26 = (struct cs40l26_private *)context;
> +	int i;
>  
>  	if (!wmfw) {
>  		dev_err(cs40l26->dev, "Failed to request firmware file\n");
> @@ -2098,9 +2111,11 @@ static void cs40l26_fw_upload(const struct firmware *wmfw, void *context)
>  
>  	cs40l26->wmfw = wmfw;
>  
> -	request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> -				"cs40l26.bin", cs40l26->dev, GFP_KERNEL,
> -				cs40l26, cs40l26_coeff_upload);
> +	for (i = 0; i < CS40L26_NUM_COEFF_FILES; i++)
> +		request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +					"cs40l26.bin", cs40l26->dev,
> +					GFP_KERNEL, cs40l26,
> +					cs40l26_coeff_upload);
>  }
>  
>  static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
> diff --git a/include/linux/input/cs40l26.h b/include/linux/input/cs40l26.h
> index bc0acec9cf23..2f74ef61b952 100644
> --- a/include/linux/input/cs40l26.h
> +++ b/include/linux/input/cs40l26.h
> @@ -231,6 +231,7 @@
>  /* Firmware Handling */
>  #define CS40L26_FW_ID				0x1800D4
>  #define CS40L26_FW_ID_VERSION_MIN		0x070237
> +#define CS40L26_NUM_COEFF_FILES			3
>  
>  /* Algorithms */
>  #define CS40L26_BUZZGEN_ALGO_ID			0x0004F202
> @@ -473,8 +474,8 @@ struct cs40l26_private {
>  	unsigned int vbst_uv;
>  	bool exploratory_mode_enabled;
>  	const struct firmware *wmfw;
> -	const struct firmware *bin;
>  	bool dsp_initialized;
> +	int ncoeffs;
>  };
>  
>  int cs40l26_probe(struct cs40l26_private *cs40l26);
> -- 
> 2.7.4
> 

Kind regards,
Jeff LaBundy
