Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CDA74B602
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGGRwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGGRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:52:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B3AF;
        Fri,  7 Jul 2023 10:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSerZKrwZQD6tcMjRZOKtTp/V3MMzBlIYdSciZDRtK+c30AiE8uf2h5p8nUzlKAtorOrXEMZGJxOfURygXKmLvtEKpGCmXlAN4fyJ6UflraR8BEyukwq0t6y8lgwKLmWFduuUH9zRLbIofer4KPVJVFXbWjtrlM5p/q+JOYreQ+m15akvnNkAk1ToTloNvPOCCsy5N2WMDW6p9gYt23qoJtgOFH9dp9drX/Rp6YjMP8XYVWQF7ak0iDkxNRULr/arQQu9xBgzU6Iacwq9n4fY8HH8Y3lbTxCUbzE6Co56cWXRECXdqVRCgDlIGbm6QJLsa1RLylwSNYFhGcfetLqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+GwzdoClc7ro2qsOvrUfRYMLyMiOLDqn/oR9Nrkwsk=;
 b=OzvgGAwyWCIQ3/TTXlr14110N5NhnodZ8hVTGvgiLKnzDMwCpk6f7r3AVG21BV8DMbmu2viWRHOUeaPeijNlOvOshCQ2yknMOXsElhnWXO+140v51Pt+1sdxe8pJDekL2u83bauxvVQsPG/anZJwsk/vjnRvQV4EbLA8av7mlFK5RoVYsBsmo0Ac63l0Bo74o4AQ+jDNiRYN7stv+iJW5UWlJmxWa5DtAUWskiUJQN78Pv1D3ECG5dupWP0PKg4Q6gQ4zU1HXKZPLQxX3VkbAx6clSFr0n1Hc14EN7JS/pqJpEoDzlQ3Al2xgFvNhTAJblFOFx/dDxSpCv5326L+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+GwzdoClc7ro2qsOvrUfRYMLyMiOLDqn/oR9Nrkwsk=;
 b=r6gGovTdXNnWprksckLqrvbJhykWtyUEl4Z7GPblGiLMFpOZtc40IzY/1Fyw5FrJw5DRIihQHbSRvC/3LyD6QpnKwXtFOvhjwdoGfgi9y09U8GUzkUlDRcDVwMbg+MXGk7h+eBJFSEHx+H9UPInCMq1KWe3lE02CuSB6+MYxdrml6FXA6PkoJZ+5yMXmsp42oEPCE7mbeZRy0qVWtXiUH82yDuVviwd+77ZTL8W54hKUb2Q8+DejTTy9jw4kPLJS/Fa7dLBm9bX4UaktKJk8sGqtIa5xu4NW+yIs+7nt3PgrUw++NE++39ZSEXAw2Q5ujKnNIpNpLXTGHOnSQejBhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 17:51:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 17:51:58 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] HID: hid-google-stadiaff: add support for
 Stadia force feedback
References: <20230707104035.1697204-1-fabiobaltieri@chromium.org>
Date:   Fri, 07 Jul 2023 10:51:48 -0700
In-Reply-To: <20230707104035.1697204-1-fabiobaltieri@chromium.org> (Fabio
        Baltieri's message of "Fri, 7 Jul 2023 10:40:35 +0000")
Message-ID: <87fs5zboej.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f4d783-1f6a-4bf7-ad03-08db7f12dc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EbFp+zTQA/2/v8KrYe7a9u5dcxTkcLRcS8XyX3+KzvosUB9n5cyVfyLmvOjO+rxv3xYRnQ0CR9Csl8NEc7gnqD1+Kk9zQVRMiREOdJLbi1TZW9nZkr6HeZ2xtUw6nXJvlmWZ9JNgfilli7NoCoRWn9lYGC/7YvCabMld13ox+ULIYNLWQyW3K1/6QhOheqb/7uXQd+OhMUd6zalXpgKsA7aFZ4Jetgem+5icImXMvml69mzOU0RXN+GOHWVAgUGvmCc+WOG6bOb8ZH7oFU6M4CsLBg8JCBeBFel6a6BMAMEr/jJB8CW7MuQQM1V/zW7dg9UcY1qUGntvDT3ggFqDCWu9v2HS2qtGoRnekEBnJdgthJ+aOSbocthxf4qR3/u+8X39QDgBqA3VTMfHQ/djsA+xOzgtd30f9zkCd4EamGhjqHmgvb31EpvNb0Sok+9HhXG4bXRUZjhzHJgyRumaapxC9rVF/J5S2nU/Bk6YoD87zGeunMrjxblR/Nob4LtVck+BvyWXOYVp1eVBW2706muWTJ3SoIAs0Bq/Kj318ks4gT5nrPy5zp8QvtB9Npv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(6666004)(478600001)(6486002)(54906003)(26005)(6506007)(6512007)(2906002)(186003)(41300700001)(316002)(6916009)(4326008)(66556008)(66946007)(5660300002)(66476007)(8936002)(8676002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwnYbGyyJqSqeDFhV7xhjUYbq4lOmtCk03tE5DRNsvLYj4Yr4h3Q2v/iX1ur?=
 =?us-ascii?Q?U57/mH1sf044q+8i5roaFDzFkqfvXyHa+vo+GfOwH8K9UgDoZF6r3breWNsU?=
 =?us-ascii?Q?8Rjrg6ICjKImORALfBL7dSPZzJGe6pYqyC/0dZtFnD3U8H6UPDNLHiiMIsgc?=
 =?us-ascii?Q?kKzhiRvBvXWX/Uv0Ilhj/eeK/FOk6+RoHwg4aia7dsGUlqiwG86zxI2tRNUW?=
 =?us-ascii?Q?/Em3h4xr9KUEZB5IQSv8Sm5mIgp/al6vIwGclU6+XFnHGWm0QF7xtN3DL4nr?=
 =?us-ascii?Q?rqz0bZIPRp3Dz+UtWMoUaR50IAICZOygOnweoz3wCdT4VXQApR+0ivXSxm/V?=
 =?us-ascii?Q?5zr7IMCi4Tu/MLYyxz15GH+klqMb0/oYS/MIELzDZ8puATRrHGpvvc3Lwgnl?=
 =?us-ascii?Q?hmBCw9SsK+K2So9PTLGNjCkr6Nyxx1g9yH97ftB5sImF/3Gf1AMxo4ipl7pe?=
 =?us-ascii?Q?ZyL/iTcUFXjUCFBxS6Hhq1KN2AXSuqLNjjh/tfWgYwrJNfGAcG8iGMQHUE99?=
 =?us-ascii?Q?arBPVR98FXM/MXihosXoelFp198d+HebZAUyo2G6qRD5xdCHzrOLx+GSdlUo?=
 =?us-ascii?Q?SLcLRMpZSL/cWjd94U8KNgBLgC21rEANozaNR97NXHwdJAsmkGuAPAgiJugf?=
 =?us-ascii?Q?qT/CucOxPRT4T4EX9yJ3zLENa+e/aOOcZ8gSFikfMNblKV4nAMTVHfq06Ycz?=
 =?us-ascii?Q?q05nbZ50/NeIchA93HboSVlndIJ/5FMhDQOohPOklAiA+7VblcRLgCGhcVNT?=
 =?us-ascii?Q?Gk31AIQ3uipP1x7MTMftjNGiiHeTnWn3D1G2Cj9qn34dhUvwQyYPlMzDhtpN?=
 =?us-ascii?Q?+WixNgaRWkkx+A0kxBfLgOFpnIrrAwb2hPhJu355YGnfgSzrnRZxlPeahrIU?=
 =?us-ascii?Q?TWwQ3PErDllzg2eBF8+80zzdRWrqazciK0PKEslnq8/e8sLb2H50GW+zJaqM?=
 =?us-ascii?Q?F1j7slI3ir0B0sYrhniROzi4MeaA5DUkB+nb7zcBhH31HF89n57u+zM38byS?=
 =?us-ascii?Q?ohZ1ORASZcGiouKkxpKz2ktKIk+BVtnYnXEHS1+1EXr/gtYky7roVzM9pp83?=
 =?us-ascii?Q?KZjduezrvKElAmpHPpL50qFNEj8vmFJibes1rS7/OKHm08GeouuH/cty5Yf5?=
 =?us-ascii?Q?OS6u/VeWUsOjAgO9ZB31riK5zs0YYGmknIARV+DmV559XiHWQJUTftlk3WpI?=
 =?us-ascii?Q?i6e4Ff9nXEzj+vw0fJwABGsI730sbz//89F3uR7jUMciZl3oYH2iPuvcbkTk?=
 =?us-ascii?Q?jwck2UgEvPWUlQW+tADGwD5nssC9ZtpSFA/6Vjfkxv9v2p9B6Lei/PGl3B3D?=
 =?us-ascii?Q?kLeVsssLD90q15QeyWQHUkRs4GzNPZZUd5hCz1rOZRZNzGgqwiiJhLlKiAsc?=
 =?us-ascii?Q?6w171qXhJu1F32lyf2hmHv3yRw8NJUYzKwoyEJy7Bq6/6lFYziExqQgupFPd?=
 =?us-ascii?Q?FrVoBaZmJFpL5m1Zp+E7wJnNJzQkUjHsnOPsgTvg2kju1Gy+/zJx9FohNaWW?=
 =?us-ascii?Q?oDSJSPTJw9ZVDnCbYO0jCr3TAmXhDkILAJnbstkrlJBkKACHcW7VyNYHd3hE?=
 =?us-ascii?Q?VxkldmYlB9Kee4jh8k0UZOQMDhapgRYk/ZeuPlszKk+MRQpRQyaeCclihKDI?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f4d783-1f6a-4bf7-ad03-08db7f12dc41
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:51:58.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z46rTI1wRANUfL5zHNkaVES244oPoV4mpLtKNzCd8FhI4YcinejAUcGemxCnK27p0KxkJXpZRZOCgyeEdicGgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul, 2023 10:40:35 +0000 Fabio Baltieri <fabiobaltieri@chromium.org> wrote:
> Add a hid-stadiaff module to support rumble based force feedback on the
> Google Stadia controller. This works using the HID output endpoint
> exposed on both the USB and BLE interface.
>
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
> +static int stadiaff_init(struct hid_device *hid)
> +{
> +	struct stadiaff_device *stadiaff;
> +	struct hid_report *report;
> +	struct hid_input *hidinput;
> +	struct input_dev *dev;
> +	int error;
> +
> +	if (list_empty(&hid->inputs)) {
> +		hid_err(hid, "no inputs found\n");
> +		return -ENODEV;
> +	}
> +	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> +	dev = hidinput->input;
> +
> +	report = hid_validate_values(hid, HID_OUTPUT_REPORT,
> +				     STADIA_FF_REPORT_ID, 0, 2);
> +	if (!report)
> +		return -ENODEV;
> +
> +	stadiaff = devm_kzalloc(&hid->dev, sizeof(struct stadiaff_device),
> +				GFP_KERNEL);
> +	if (!stadiaff)
> +		return -ENOMEM;

If we fail to allocate stadiaff, we abort init without ever initializing
the spinlock and work struct.

> +
> +	hid_set_drvdata(hid, stadiaff);
> +
> +	input_set_capability(dev, EV_FF, FF_RUMBLE);
> +
> +	error = input_ff_create_memless(dev, NULL, stadiaff_play);
> +	if (error)
> +		return error;

Lets say input_ff_create_memless fails. The spinlock and work struct are
not properly initialized.

> +
> +	stadiaff->removed = false;
> +	stadiaff->hid = hid;
> +	stadiaff->report = report;
> +	INIT_WORK(&stadiaff->work, stadiaff_work);
> +	spin_lock_init(&stadiaff->lock);
> +
> +	hid_info(hid, "Force Feedback for Google Stadia controller\n");
> +
> +	return 0;
> +}
> +
> +static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	stadiaff_init(hdev);

Is the intention for not error handling stadiaff_init to be able to use
the HID device even if haptics are not enabled? I think that's fine but
there are some design considerations that need to be made in order for
this code to be safe in the context of stadia_remove.

> +
> +	return 0;
> +}
> +
> +static void stadia_remove(struct hid_device *hid)
> +{
> +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);

stadiaff is unsafe to use if we failed to allocate memory for it and do
not set the hid device driver data. We would be dereferencing a
driver_data pointer never set/initialized by this driver in this error
path in stadiaff_init.

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&stadiaff->lock, flags);
> +	stadiaff->removed = true;
> +	spin_unlock_irqrestore(&stadiaff->lock, flags);

Attempting to lock/unlock a spinlock that may not have been initialized
if an error occurred in the stadiaff_init path.

> +
> +	cancel_work_sync(&stadiaff->work);

Attempting to cancel work on a work_struct that may not be properly
initialized if an error occurred in stadiaff_init.

> +	hid_hw_stop(hid);
> +}

Thanks,

-- Rahul Rameshbabu
