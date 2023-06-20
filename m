Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7673620B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFTDKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFTDKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:10:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2D10D4;
        Mon, 19 Jun 2023 20:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh3MvNGg7asIc+yDgP5+cRY3vG5+TNpa1psy+Val5SGvPtylAFUozNugEwInPLVwVf9pm2d0brK/8NK5GV/8Mjk65ZHIzMhh2WnVRM6zcEc+CkOCbw2iRvtrsPrWVPOMUctKWotSAMZ7e+OefuacluahsCyiyalVHGrLqjy4E2Z4TmnGCy34qtFIwpJMDtTtYKsnfFEH9octEAUlKrclSMNM/gNbe55Q8kM0TVupAuRLtG/1fJ2BywKWiJnDYfR5/PapmUfmb6FdfVQjnoAM/lA6fOWQeuc0JTIgyAnNPk7YUaPrYL2bA3sybUW3qBw212IAAppI3BnTp6Og+baFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7HpLaU+VQq6DkC5j9Kb9h1TXuy360P6tuOHzQscOCQ=;
 b=P7Mzu0QRYffSQWWQ+s1XhlN6ZTgUszpZ7ud3gdTyuH6leV6VbFHgJfRkyiM9rcq/LDhSZ+z02GaqFqSSDO1LxVDu8VH57uutQ0FKkLtKOV7x5u11CbQlJsodScf8ngrWp4qhsOBHQrMP0kRYXQkWkWN/KnuGwAFFxr6p0HvqiEuJXcmR2D6K4SSM0gi7jkCJLxb5Fcs+9Rj+IGfZwYzURYZnQy63ZRa3I0onaZrLV1oeHSv3JNBUFLQsWDk9uw02V/DSVWDtfZZFJntYJtvdd7VdLhIeX54KR7oDLyzut06UofuBXvAsnu0uTz9HNBzEd9DJyoqDzLYsARtDzhrJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7HpLaU+VQq6DkC5j9Kb9h1TXuy360P6tuOHzQscOCQ=;
 b=EVlEwxfT5Q1S4V66QWw0oUkIrrk9elU9JlgslyAGeOdEgdwVDOGwUZ5g7NBCdA6QXbvfBrbqZn8Ilquc0XrKkgCmfeOGbwoDHmmNv3LVWYPaWl5kMSTzJ/45JMwIQDwmOrOX865cWtIHl7unyVeVSxQxpQcPN1netLDMr9+g3/o=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 03:10:03 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:10:03 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH v3 1/5] cpupower: Recognise amd-pstate active mode driver
Thread-Topic: [PATCH v3 1/5] cpupower: Recognise amd-pstate active mode driver
Thread-Index: AQHZouEO9VXDIpPojkyzLl5KiJ9lNa+TA5sQ
Date:   Tue, 20 Jun 2023 03:10:03 +0000
Message-ID: <CYYPR12MB8655D16BE027009F663328909C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-2-wyes.karny@amd.com>
In-Reply-To: <20230619190503.4061-2-wyes.karny@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6dd7101-86df-45e9-9674-ff870bd79338;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T03:09:52Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 29c84d89-cb88-4047-0902-08db713bd769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C47xAfB0Gy7R0TuRR9HzItnB66fJfh2EEDnX7nLpXzjt0b3RLDh1cpy1vbn1YK9KuMhhGFIb0U7rJAXDeLm9TCkHS6KQYCoQnEHFHz16CFHKF5za0vRcy+CTB1DV99prY1oJTYL0g7+xacEZU9a36snQWm+WBR75K+K5oKje7bM5hHLPU5phWS2k+spiwVJ2ogAxTuyBqMzDaxeKPPdnqRBTG57sS80foYsqNU0kEeIZJMF1vweoccEjrvsASRjxePXaktaiQcdnVwY9n9Y2m6matFnAZ3k6Q5350wqlFgEI9//3mTwAaC2lOSQ7zDHkKE0C96YhU/spuZDy1X9bk8wj+EqWIqWNzTGyWP1OLFIJ77SdMCB8b00a7tezbDDjnpNIyX5ypG2WxDytXfgnVHLhp8gty5N4KDQ3xLODprlh2cE12297erUvLfD9PYUJDvVTfmzWyQO5NqMzErMpK+4xQkfloezu6NU8tqGA0Ayaz3Kw3S+3zxqgwv7rvcKrkIV8/a+nP/N6Ml9XtTdO0kvtIboSyycoj5rI5r/urei4jZstPCcvndGdMoSqH/HOfezr5kq8X4oHYIuTdCFqOQ4F26hjoGZ/Y2QEJK1BTysxvBBqSR1l4kH2kfKMM2Ut
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(478600001)(52536014)(5660300002)(4326008)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(2906002)(54906003)(110136005)(41300700001)(316002)(53546011)(7696005)(71200400001)(8676002)(8936002)(6506007)(186003)(26005)(9686003)(83380400001)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F0gTXmtVx4pzpL/fWtPj7cyLfMnwWAzafUWYb+dPT6szDhbtpqOpOBHSdWJ7?=
 =?us-ascii?Q?xsN6Pc379zVgKqhkgmtb/hGHLEirMnLxIWB6ggAf7MIzuYcqWNy+CoMAki2j?=
 =?us-ascii?Q?X89F3LdKPq9FmV5JdOIxD5DRTwkplyDIubQveDiQTo+QiZ2FOMQT4cui3/50?=
 =?us-ascii?Q?IeW8gxGveb5YIyqjlyLNRqU+xzCKG9eeSLmFYn+gkHEy9Ny+hYo40uCPGFHM?=
 =?us-ascii?Q?6G/KxJhBFgqQ+NBLstmFiaqpNJ8xcFvYU0WbC3ioSsp4vW8fn82By7NZU2kw?=
 =?us-ascii?Q?EXOuI+trq29H0CElcMjsTAVl6sqj49aVTytvevmELjEUvxIDv4DLnMbP+4Bh?=
 =?us-ascii?Q?1/Jd2hc65BFMyQJlB+Ed0SaF5NBfPF9oBgOB6wa+XFUBXvJlHXlshPxSOTJ8?=
 =?us-ascii?Q?E66tKOs4CQp8DvroJ1eH4mELDweFTe77d7mhS3ruq1k9IiF5e5IWQ0Q9pZtX?=
 =?us-ascii?Q?CFiY4vOia5YNI6lfP2UYVZGGNFSo1mMVG7DhC1HOeKvVqCn0ObdQVr3qMEpq?=
 =?us-ascii?Q?g7/QNVOSMLBEx+SNjtzyXVIh7m/JALUac0cHHD24yMCoFIokJ0WzOofnmQ9W?=
 =?us-ascii?Q?opOLhhx4Fbsitjr9NI6AaqRUbK0qyTED2ExqhVuRjxuL4q1mvzeDgQSJqeB1?=
 =?us-ascii?Q?WG22zuLRuuj47xWg2mqmWUEFEFN547busRKZy00kkfXavapW83kP0+k5E3jd?=
 =?us-ascii?Q?LejcLR88iqdurwyIWzqNLzHbFf/5XXwyCA3CTn9kNgT+puEnEuAmAMvCVpY+?=
 =?us-ascii?Q?0lk58q9x9H+JHTioHTFyoYva8KQJ4bgnCa7adh3YAFKJDf22TZgl7sDpyBJJ?=
 =?us-ascii?Q?jOWh65ScVJPuRZzA1B5FoQhhKYz4vWhlABBNTCu2enuQOEfFk6rT42Shgutl?=
 =?us-ascii?Q?LVG4NAY8kFp4yOtrNmJbkUkB5W3AF/vkgObvsB7vCeb//ppa6LFSJhAa7+kh?=
 =?us-ascii?Q?kjC0FXcqJwdqEwZYitQeuy6Z0g5jhJCRJLqMYx6df8ISade9G7/yRbEJnWNt?=
 =?us-ascii?Q?ugCWiksu8X11vmEoULZBEARuRcY7jvTjn0FgjgPp9IBGY+0aPvpU3UaTJKuV?=
 =?us-ascii?Q?akxERbizyu+Bq5oatnw4t0/6YV2T8k++Rgst/bxhtztPNzfcainezTAa28Mq?=
 =?us-ascii?Q?cY7MZx5eBumvbtX6cOe6ldbnljSH8mlgqnvKA+oZIayL2+rG0NC4MQHhEcCD?=
 =?us-ascii?Q?VfPuKSAITJInxfJMOOHOnyHcR+ErRbGBhBaf0hJFCGaV/OxCSpsVZQ7+tT4c?=
 =?us-ascii?Q?vyYhH8YJ5hUZa88WuybGd1ohhJA9dliyiHoZ2Flj/wSlDwgalmVxcJ2NvunU?=
 =?us-ascii?Q?RLPKEgHiEw/Vr68LMdtsgiJ8/O8fLOwBm6B8lLUSWo14H3eUcB7A5/ZGc9sN?=
 =?us-ascii?Q?LoV7U5oVmcHW+dOLkvBDoYH1UcweFJ8gloCNZb2j5ocxuwQLLmBD+zd+M43r?=
 =?us-ascii?Q?7VDwz7n7W8uizbywMy+T76vjeBp+LQ2zHu4SbPDaZcaa6gtBndvHdx7Fbn2z?=
 =?us-ascii?Q?ZfEC7GE0uKreUiGeVu2I+nIsimTpMRX+FSt5k2LOMTILg9B/7KnkSL42pIg4?=
 =?us-ascii?Q?xwVEQ890kYb4wKp2gHY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c84d89-cb88-4047-0902-08db713bd769
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:10:03.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2JHTtm2wy3kSAKZ8V4RbLRdd0yXbhW1LveSRNj7P8evuzGOpwrVD4ZkgWHmNcLOg12qgGkDXzSn6rrDbrR8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Karny, Wyes <Wyes.Karny@amd.com>
> Sent: Tuesday, June 20, 2023 3:05 AM
> To: trenn@suse.com; shuah@kernel.org
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel=
.org;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yuan,
> Perry <Perry.Yuan@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>
> Subject: [PATCH v3 1/5] cpupower: Recognise amd-pstate active mode driver
>
> amd-pstate active mode driver name is "amd-pstate-epp". Use common prefix
> for string matching condition to recognise amd-pstate active mode driver.
>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  tools/power/cpupower/utils/helpers/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/cpupower/utils/helpers/misc.c
> b/tools/power/cpupower/utils/helpers/misc.c
> index 9547b29254a7..0c56fc77f93b 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
>       if (!driver)
>               return ret;
>
> -     if (!strcmp(driver, "amd-pstate"))
> +     if (!strncmp(driver, "amd", 3))
>               ret =3D true;
>
>       cpufreq_put_driver(driver);
> --
> 2.34.1

Tested-by: Perry Yuan <Perry.Yuan@amd.com>
