Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03226C293F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCUEop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCUEom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:44:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381028846;
        Mon, 20 Mar 2023 21:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUPGJPgxZJ2b7RBGSzcyipJ4ssxKl9SRY20FoaC9Uf/DImEt5/p0L7yayHROuSFiyvikYtWBJ1w4sPyYrSGXzD3OkDxplTb2KdfJSoTpvZ+NeVfhrpsLN6RQx18Z/QjhTRnfaoOx2p2zaREtOuG+dOEcPB3PM/Dk4DORke8e0kuuD3UkKB1ESMTC93Wp8SzT6KiCTB0lsA1T+mAuKeRZ0cYdOkhGkLu+eLfL+7ZrAI3zLQ+qFZsERJekKVjFH1b3r/xGPzedh8ycd8OTn0pbmqsNN1OZNhleEu3eDqCfZ/KMrmn255eGDxyb8QyXBnOGlyV4EmmfCGw8OPJh2J6LQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNos1xbnylRBd0rT3gEQL2YYbrjPbQ3hcYvJM+C5EGU=;
 b=NW6TRzz05TRILEpZYbQsXwthG47x4h7dmUpBq71fIpfA7WGrHo70g5P6GflQk9WwHFBTKsxbsnJ2J4RYggAbcv+yiQ0Cci8QsP4VZ+r883z30avgZYmWNtiObSBlgQ2dyaRN+b8o54dpo9WGbqr4rmbJSgBXQ6YJ5dt21nwSlNfdQrk0aO4Fn9ejSvJ6zmZ6su4on1rOaD/2SG2o29bt2x+73nbJvjZWHBbnNY3CVFLoRwGDzisp5iA4pF3aGivHxEBabHZiDMikd+uL4zrgS/RucuIMeqnYeL/N6+vxLWY/Ft0xCSglDTLs2Z33zD+92PzTBTrEzwufe+cRR4S3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNos1xbnylRBd0rT3gEQL2YYbrjPbQ3hcYvJM+C5EGU=;
 b=wAfIwkSnlUKftn+nX7ypYsAE/i3n/xTAZyTtPLeIHZw9KDiIWD50XOJBSpMe84Z5VmK6u3qQ0oJiwLm3UGFAvIPhNvI6GOj8ul4K241/pRmVad+ik1ud9SQBSDxvBPA4inNzv+UKPlkxZNkCW6aub4lJCfqeQwgn29PFGACloAkVSVYYvnq95a6+2l8lTLrPrMoa9RvqiVke1V8EwgOpRT/iBCI2I4H3/2Ko0aZIdRgVlmS9osFPszxkAYNNpgIjzOX/z1USwXCTS+dkDIoKLyoU5CgVy4wnizI/xkIJZxKU11hEgYDGq3Od5+eMfWyEwnf5mcVB2wj3BjbBOmdqFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DUZPR04MB9948.eurprd04.prod.outlook.com (2603:10a6:10:4dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 04:44:36 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 04:44:36 +0000
Date:   Tue, 21 Mar 2023 12:44:18 +0800
From:   Chester Lin <clin@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 1/4] pinctrl: s32: use of_device_get_match_data() to
 get device data
Message-ID: <ZBk2IksVZ7N6wKeP@linux-8mug>
References: <20230320163823.886-1-clin@suse.com>
 <20230320163823.886-2-clin@suse.com>
 <CAHp75VeVbV8iC6J63PgnE=i7EajvrDhFnEUcq0H_fRGfMMh+7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeVbV8iC6J63PgnE=i7EajvrDhFnEUcq0H_fRGfMMh+7g@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0300.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DUZPR04MB9948:EE_
X-MS-Office365-Filtering-Correlation-Id: ee615626-952f-4171-db66-08db29c6f8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNYgOPtUwWXDbt2UQq8fbgXkPgcMETalOT5WuMajrTDO0aV2GWKtZFEwHQAfLkvjpssUifXs1Z1uxc9Q4XUAjx78tn/6m2htSn4eHPlVoUlIZZnJYEovJpep4n8gvjklMdulC1+euEM2aVNBQtYTKdk1RTGF+5YrPGt8QK4koZRFROPolDjB/Kx+RgaRSaRlVhatumZAdZoccnkGZrhuot3yTsb04QHmwy18uMSwsE4vfrXqohwGLl669Gh6PFpLTaKZLIus85UiYt0j2RmLuxaOekLx11gMGfo3/Z7PJfyA7671UE4qyAMqCTWzQPLMvVIqsfQ17BSNMgqUIrO9ToLoMAQBNViK5INloBPfZY1AvEGJGJ+Q1SbbGRp4v0+4qPLm5bz4VmiQGC+PfUsD/E8ypMvu045Rf62ZLt6sA9bG1HWQjsdlRHRtvB/+gjxoLfRqh1FpxkaU28DmRKhhlZrxbrRKYM0bV8TEN+n86o/I5YKZ+8nkv+8lqcshFVzPwUPC18rtOPQvLAAAx+2s9h5GehlASX00OBN4PxXcZd/W3KP1tUynxqQHd8LcmvBVenPgcaaSouUHabDQEEtuERm8KZReDSUQAcVb1/430aYx9WHLidws0GMtdqNcw8WD0QoC1NZ99z/K2jIDG4J9Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(33716001)(478600001)(83380400001)(316002)(6486002)(6506007)(54906003)(6512007)(7416002)(107886003)(186003)(5660300002)(6666004)(26005)(9686003)(2906002)(38100700002)(86362001)(53546011)(66946007)(8936002)(66556008)(6916009)(4326008)(66476007)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZxOHlGM2dkS2RGdG9QYW1PbEVVR0FtaThwT0FnQlNQWXJKOUM2S1cwV2sw?=
 =?utf-8?B?TkIrUkZ3dzBEL1dzOGI4dEdKOUtyK253U3hkenR6MVUrS1hnUzVXTk91cldo?=
 =?utf-8?B?SXo0L0M0UEV4V1IveVphRmFWODgvTUk1N3ZWYTg3SnpSVEhCM1p6dlVJRC9T?=
 =?utf-8?B?S3I1TzZkQjdwaWpCOGZHTEc0aGd0TVJhbDhJcU5zeVpoZ3BMTHZKU3ZESWJK?=
 =?utf-8?B?eEhJTTdoNlFXSDZvd0tXSG9tN0J5SHFQb1c1Z0s3cHdVN2NPU0txcDNEaXFY?=
 =?utf-8?B?alRjeGxOR3RKUVUyNEZzQ2N6WkY4UlJBVVZnYzBibnlSVnNyUVFBWkQ0UGV3?=
 =?utf-8?B?dHZ1N0hkMjI5NFpaTXl2ck1KT0xNMXZ3MjNPeTF3QlNycE9WNW9iMFhRYnJI?=
 =?utf-8?B?aTZxNnd5VFFyZXYzeHNWOXpjNS9GZWpKTUR6YnRpUWpOSk5hTml0V2JsdEhj?=
 =?utf-8?B?NTJmR3p3WTNOb0RuWXF4Zy9qY1IxT0hDekhGYVQrZ1hHVFVDSWUyMWdMSEpM?=
 =?utf-8?B?YnF0WS8wNUh4SjhnamNkM3BlQVZIOVU2RUQrUHdFV0R2QnI1Mko1QUlCaGRj?=
 =?utf-8?B?YU9ZTnBnajB0VlFPeHRidE5pZFM1KzRRZmJDdmdTbU9IY0U1SEpEdFJFMi9Y?=
 =?utf-8?B?eFVEVHUycHBUTm5pdnVJMkNhVlBMYjY4SmptMTJUeldRanNwV1A2dUt5UXow?=
 =?utf-8?B?OVNxdS84b1RNMVpHbVV0RVhxWndFVHpJMEkwTXd6RTNkWW5jU1lHTFlpMys5?=
 =?utf-8?B?YU50ZHhrNTF2RGpsR3d1WFJvMlptUTIvQXoxQnFqNFQrTDltSVVzc0VHV3pL?=
 =?utf-8?B?Mk5tYk5HZWx1ckQzQXJqM2JFWnVEdWo3TGloRVY0cXZPa0xXckVlRlZRWE5F?=
 =?utf-8?B?NUx4dTdBaml5aFpmTFpkV2Nna1RLNlBlUG11cjJTM2d3a3pqUzhxWnowSDNR?=
 =?utf-8?B?UldJSE9DSjM3TERVV3J5dWpQSk9VbHVMbm9yMkNrRnNSa2JtdEtSZ0NCTVF5?=
 =?utf-8?B?ME8vNEtmZUlrK0Y1RTBqZVBMbWJMSnI5YlNsamRjUUc2amQxek44SGU5WXZz?=
 =?utf-8?B?ODUwcGFjK0hpQ0cxYkVVZWIvcGN5SUhGYWt5eWIwTTlkME42VnJaS3hhZFRT?=
 =?utf-8?B?ZTZHWC9JYkZRSUZHMVdMSVhFVDF1cnVtaHlXUVQ5OEIzc3duRmZFQ0RmNE1W?=
 =?utf-8?B?L1FvU1BtVVE2WGR2MHVVOUFqWjRLOHAxcWx1MTZ5eDNacWRlV0hXRk9jNFNo?=
 =?utf-8?B?VzZXczZ4M2F0Z3ZVcVdYbHo0Zm9JODBLM29ZUVgxSWtrdUdORnVzTnJtSjBp?=
 =?utf-8?B?YmdXRjVOSkE1V0RGd1k5ZGJzSEZ5M1NiZFJhWFVEb3dBYitsUkdHVlVYaFhG?=
 =?utf-8?B?UGZLN3Vhc21XWlExR0puaGF3MkZXYno3QitTVHB4a245RHFRV1FNTHFWQmtH?=
 =?utf-8?B?M2F0dThLYWdCOU1rblNITzRrZkd1VjF6cGI4TEhzem82ZGlwQjhVVWY1V1NE?=
 =?utf-8?B?RHFZQU1jQ2Z4ZE1LcDFLVXJzQm5vQXYwRCtzbTdLNzA0V0drcWhiNnhvaXNF?=
 =?utf-8?B?ek9JVWw0UjZDVDR6a0l1VGJwb1huck1DdHhnU1dWWDZWL0Z3cXZ5ZnpGVjlS?=
 =?utf-8?B?TFYzKzI4TmxNRUc3RGJpZmNuN05QV2dMOFhkYTkwUzVQZzRUZTJObzhua1JM?=
 =?utf-8?B?RWhhL05FNmREcmJSUXZMZUhreXpHM1orWnZiaCtEUXI1b2JvSEV5am9jVnZJ?=
 =?utf-8?B?Y1UwazhFMjMrVGYwNzdUMDc1eHdkUnlQWUVQYzBpUmVibzdyVVFXenpKRlk0?=
 =?utf-8?B?eDYwWnRHbEQ4VHllblc0ZEM1eVhmWmJyYnRqRkg3T01JOFhXUmVqRUVldzJW?=
 =?utf-8?B?SXVuMHN1bVlzeitQVU5SQXRkMXVsZnd0RVVFQmo0K1NRUWlObmFpYy8wTGlo?=
 =?utf-8?B?QW9ZNG84azNoeU9kY1ZLQTZKQVJnaytscWNHUjFGa1J1dG92NFJFT1NISDl1?=
 =?utf-8?B?cUpjdUVJSEh6M2R3NFduUUtIaE90ampjWUhtZ1lnclR1YXQ1Zm9UclBiV2d4?=
 =?utf-8?B?azRGYWlhaVZ2Y3FNTmgrQnc1OXdsV1VZZEJzU0lpSDZMOVNwZlp1VDJLVmtu?=
 =?utf-8?Q?OcC0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee615626-952f-4171-db66-08db29c6f8af
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:44:35.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNFNloWr4hO47YVEklCjWNFrzQTogWPMgHgjXUQ6Qr0cLEH0KIE9wn5Og2wKtD0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for reviewing this series!

On Mon, Mar 20, 2023 at 06:59:41PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 20, 2023 at 6:39 PM Chester Lin <clin@suse.com> wrote:
> >
> > Instead of relying on of_match_device(), using of_device_get_match_data()
> > can simplify implementation and avoid code duplication.
> 
> Suggested-by?
> 

Sorry for the miss. I will fix it in v3.

> > Signed-off-by: Chester Lin <clin@suse.com>
> 
> ...
> 
> > +       soc_info = (struct s32_pinctrl_soc_info *)
> > +                       of_device_get_match_data(&pdev->dev);
> 
> Drop the ugly casting, it's not needed.
> 

Actually it's used for suppressing the compiler warning since some members in
this soc_info need to be filled by pinctrl-s32cc.

drivers/pinctrl/nxp/pinctrl-s32g2.c:745:18: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]


I am thinking of allocating & copying a dedicate struct in pinctrl-s32cc.c rather
than reusing the .data attached on of_device_id in order to solve this warning
properly. Here is an example based on this v2:

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 2f7aecd462e4..f3a0b579757c 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -51,7 +51,7 @@ struct s32_pinctrl_soc_info {
 #define S32_PIN_RANGE(_start, _end) { .start = _start, .end = _end }
 
 int s32_pinctrl_probe(struct platform_device *pdev,
-			struct s32_pinctrl_soc_info *info);
+		      const struct s32_pinctrl_soc_info *soc_data);
 int s32_pinctrl_resume(struct device *dev);
 int s32_pinctrl_suspend(struct device *dev);
 #endif /* __DRIVERS_PINCTRL_S32_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 4ed0cc905232..4c70ab753d15 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -899,20 +899,28 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 }
 
 int s32_pinctrl_probe(struct platform_device *pdev,
-		      struct s32_pinctrl_soc_info *info)
+		      const struct s32_pinctrl_soc_info *soc_data)
 {
 	struct s32_pinctrl *ipctl;
 	int ret;
 	struct pinctrl_desc *s32_pinctrl_desc;
+	struct s32_pinctrl_soc_info *info;
 #ifdef CONFIG_PM_SLEEP
 	struct s32_pinctrl_context *saved_context;
 #endif
 
-	if (!info || !info->pins || !info->npins) {
+	if (!soc_data || !soc_data->pins || !soc_data->npins) {
 		dev_err(&pdev->dev, "wrong pinctrl info\n");
 		return -EINVAL;
 	}
 
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	memcpy(info, soc_data, sizeof(*info));
+
 	info->dev = &pdev->dev;
 
 	/* Create state holders etc for this driver */
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index 9f521312f768..0a49205414eb 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -740,10 +740,9 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
 static int s32g_pinctrl_probe(struct platform_device *pdev)
 {
-	struct s32_pinctrl_soc_info *soc_info;
+	const struct s32_pinctrl_soc_info *soc_info;
 
-	soc_info = (struct s32_pinctrl_soc_info *)
-			of_device_get_match_data(&pdev->dev);
+	soc_info = of_device_get_match_data(&pdev->dev);
 
 	return s32_pinctrl_probe(pdev, soc_info);
 }

> -- 
> With Best Regards,
> Andy Shevchenko
