Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A75F6002
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJFETS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFETP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:19:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75007F0B3;
        Wed,  5 Oct 2022 21:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqh1L3rYVmzXw38IiE9u07/CtZbllNvEYaQ2dlgyTRVDcREUf/gZ504XoRd8FiOkE46VinRb34uFzkNPDi7iszP401S10W0lGhwslh/v4cYuWQrneb61PqGIoKXNi1OqFBYTgjqVIgevwQBvTgAYHuWjx+WKOnlqEqzTJ1wB56rH4kRKlJugZ3aEEJg2c8XePjAubd/zkxO9ee4C4ZNqKiVd3yqCBAb30bOnbb8wC4lrENhmuptrAXcoA3XHmI4yCRCYR2B5T+SqhkaUsbX/iVbaOTvUnDUX7Bg1T6w3ev2HHt0L7DD/5f/ASliZ2HqClLYgBp+1nChLu8JCV93uMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4vkDtIwumMrvawqwS8X0eHZoiyihp+OI/GY1T8U+oI=;
 b=LgnoIzRaGxDKeTpmTTaPfKsZJrEZjJZaNn7coE3q2h/O8BJvxMcKR56ddHDf20oCYYr2AqDb0T+mi6eJSBFS6um1q0cXIaOwqfcKx51E7tsTG5eztk4w0N0Qndgp86KBj78dYl43mm4pI2kY692QBNKICXgbXxCC9se3pJV0m16ehCiRpHmECZb2FEax3Edchit+E1tskP0OtqSSWczuSxhWT3V3cL3LS9V4pGUFSnM698KowPO6q+JOrsyEewsudBwBIf3/e2lXqBcWFRuuxUCAVStJ5JaDGDTTR608nwWNHqxWffJOAhcCcAguXQHTFFFW6HHiZc/YwKY9GQfrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4vkDtIwumMrvawqwS8X0eHZoiyihp+OI/GY1T8U+oI=;
 b=ihohSUuy9po0szm/70KlCDnYUeZpPnimv/ZDuS5bpp1bwA/O+oouQNJL7TaYqjSKo87+CC1wAJMixpI9QiGxL0g8i6fvvYDpoUudb5gLDRUoZTXlMxA8Zg7aZHI4sY89kguAAEttASyXND5YS51DzhFoxce1EiKNhoKWPpUX+i4=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 6 Oct
 2022 04:19:09 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::146:6178:c8ef:23eb]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::146:6178:c8ef:23eb%7]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 04:19:09 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: RE: [PATCH] clk: clocking-wizard: Depend on HAS_IOMEM
Thread-Topic: [PATCH] clk: clocking-wizard: Depend on HAS_IOMEM
Thread-Index: AQHY12ZmWdOb4Not3EinnIdj5GDpqK4AxqRQ
Date:   Thu, 6 Oct 2022 04:19:09 +0000
Message-ID: <BY5PR12MB49020F94919DBC52F5CF200D815C9@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20221003202608.2611295-1-sboyd@kernel.org>
In-Reply-To: <20221003202608.2611295-1-sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-06T04:19:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=110a8fad-552f-4e75-b8da-c524074b6d90;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|PH7PR12MB7210:EE_
x-ms-office365-filtering-correlation-id: d6ac0cc9-adc5-47de-6a22-08daa751eaa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWAUhdPe8yxSnNZhXpTkm85C/myaTcftnnAZF8I0BRLcbYwMiN0LJRHQGlxhK2rd5kIOBNwXMCGcdFzABLpcCmf4HOG6VgW/zowEJf+ZjEo19jpO+pwrkA0G96bN1CAC/oOS+lxavylfNjUBMcMXA2ibpE0MVX5TG0AG1x4jm3uGLQJocYuYau/ZH9GAjFWgsiqlzHLqsWVKwh4wBXaGVt3qvITQ46/zu48pTSGBVE1zWRoG4skpINWWcg6VK+KBB3+bcd4jq9Ahw4gvIFPyjt+zHHxEuieSvzcKwBGp3UIdCPbfPur9+xZWovrYw2hqYjD6XKCGZdMsa/9SQ78X0KtW8e9X4iR7nrCcAUqNFh38Hcrm59/HZS90tdde5E0FlMAQt1EGfDi45It84JSBjOof/R53BreRPPAg5iNssfAEx6cGO57oXPtpmmUbcDSS97SbxfcmMHThxP8OTyVjo8v0Gw3Op6wO1nTAVE0e+Z9YbCdF0xQbU8+kZcRDljncF9IRjODHtmMGGbrh6jwh+KKBrT6YERsfoU7Ac4i3SQAK/vMmZY5SGtLHrbzOYPjmjuzKR7acdl0xA4J1EX+0eFAxkyHipjq9CNkE3Lxln7qGbMWF5OzTObll0zCcIvMVAvTYUWFCEFH7qwKqmNY5LWh9urn6YKJHQYK+/K3uqL3a7mDQELtZ/M5SF4tPktELfVTwjsM4T4NID5NEISGXYRGtvYEdmm4mB2ch99q4/UxPWe8v3DW+Wtd7aUXJaw7QrsH/B1GcYVnbcJQP65VvTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(5660300002)(122000001)(71200400001)(478600001)(110136005)(54906003)(316002)(38100700002)(9686003)(6506007)(66476007)(83380400001)(7696005)(41300700001)(4326008)(53546011)(26005)(107886003)(8936002)(186003)(66946007)(64756008)(66446008)(66556008)(33656002)(8676002)(4744005)(38070700005)(55016003)(2906002)(52536014)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWHQt8jmc2ZfqpTZNAklYgFbXjBCcUyhzUJ5csWUHmvq3eM+pkb8dVdU/uCB?=
 =?us-ascii?Q?0hM7SRROLuJjB2XPDzdKwBFGPEolIBGEGj1ydSjjPRBjHgM6LSnBkheF1a5g?=
 =?us-ascii?Q?ImbwEho+JrEsegYw6uc95Wc6k3EaR8cF8bic+4Rk107RQnESwz0Fo90BAOK1?=
 =?us-ascii?Q?/1nsNOpd1HvMRtvPocO06+QTqwY0qM4kf4OzI9pJVONP0F3hRCJvRgocYwot?=
 =?us-ascii?Q?H7bpMBCx1AnhUZ+cqSDqRI5/cdo5JODiwvCXKMtta+1cXCunH7wKNeuvwiLJ?=
 =?us-ascii?Q?OeBkKpCrazSKN1Wfi4snLuSiOmVw7842kahhzFg9P7tjPLV4InuB54dtK0HV?=
 =?us-ascii?Q?2kpZsqZuhrAjkXQO6R+guGQ1omxRZV13pgbcmjlWiJtfckbRBu9KxFwXPLnS?=
 =?us-ascii?Q?4PLOW9/rzcoXHG1lG/Kc5s5lCO8g4ZHGvJjtilHgKJN0LRLtqO6bVF2yJrSh?=
 =?us-ascii?Q?C5ZLrRp83eDtKaXPucIonXHnEuRlAXgA9af6YeniHrVM+TJqlmOHNKydWShx?=
 =?us-ascii?Q?3E1hvsJO/8CGKnP07rY2ZKwNzgyyiJMvO5JSMTOSeuMqmmwUuyPOY5vxvEmK?=
 =?us-ascii?Q?xgWYZK7HVE+JlxiWL90ez2e6MH68ZU/VZmvXDCQFkaEb/XNWcEUvwCf0xEGH?=
 =?us-ascii?Q?NbYHJtVy46XjVT/iojcyXfTqFV6hC5Rc+UfGkVMWqHJ7cJh5QiU+LgCwh+TT?=
 =?us-ascii?Q?zgvsmiG5TuswjTTlexiLIFY7n8xAH+yxKEmPbVnhr0ZtSgLNryk6wTBYGUDD?=
 =?us-ascii?Q?BTo4l49xbCihtAtJItJtV543ZB89ULQZu/WPWAwUoUZeRCiTVNtgUaaJ9pVM?=
 =?us-ascii?Q?Gjf3mgWKdxQyzkyBUbzAP+qaY+uStcKg5og9GIlp2236DrdWvQKLqVQTJjx/?=
 =?us-ascii?Q?fDVPuguXbIysoLMT/422PYQ9SX+9aEMZRRktUcCPalK2KhNWXB2Ppylmp988?=
 =?us-ascii?Q?ux69VHPUz3dtg7y6V1gckqPBzoLZ+FM10jIo1hNQKmh5Zo3tE8/B116css5C?=
 =?us-ascii?Q?dK/TarpW855zvLCPAVxdK7ASBRt7BcnQkDsgoBU8kmawwTaGhipdSBLOq9Ip?=
 =?us-ascii?Q?7uE0RVfxOzjxVuOtRdFyudjUAKXd74iNErYaMWu0/cLGsj3MjIalzpHV5Odv?=
 =?us-ascii?Q?jqieuCf4EuihN4yslJUNApVg1Lk87B+NJuFhvn9Es2FHGOSbgivC83CexCW8?=
 =?us-ascii?Q?Bmk02JrFRonN7g/m39JQRJOkZLQ2MX6kU0uF6oScb/wVtM6LqzSLvQ30o4ml?=
 =?us-ascii?Q?LtE2wgA0WWBNqDXlCxWqjzRQwfAgzXs9adoof8o9GFIG2omawwKmPuGZSWJV?=
 =?us-ascii?Q?gWvZtWhEa+Ks9I9bBZsbQySyj3S7/9Kd1Cj8DDCrg06ubWUUZeMD3pxaKpgj?=
 =?us-ascii?Q?T0Zm+IaSBGNks+EJkbOTLT/N4P97uaQuLq8eJlbzGyworB5ZZTDk3K49hPcx?=
 =?us-ascii?Q?9pg40JpFSog3+6X+3fTMspPZbbHA1t5VVamiMnTY6BQtXhkzVfKSkdIRuPxr?=
 =?us-ascii?Q?/fJDMdOiwEVMNFNf8KA2ey9583+PIU5csgy7TSVokRkdb2md+lORIwvF9yes?=
 =?us-ascii?Q?rycjQ16Hum5TQh0rMos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ac0cc9-adc5-47de-6a22-08daa751eaa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 04:19:09.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhrGYPzOj1IXYq7nKed2B7GIraCcdQ740Yry8WaHNBNmgCT7gp37V+RsZrxraWN6FAMMXao9yTIsPuuryXmRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: Tuesday, October 4, 2022 1:56 AM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org;
> patches@lists.linux.dev; kernel test robot <lkp@intel.com>; Shubhrajyoti
> Datta <shubhrajyoti.datta@xilinx.com>
> Subject: [PATCH] clk: clocking-wizard: Depend on HAS_IOMEM
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> This driver uses devm_platform_ioremap_resource() and thus depends on
> HAS_IOMEM. Add the Kconfig dependency to avoid build issues.
>=20
Acked-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
