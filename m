Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399BD742DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF2TkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:40:12 -0400
Received: from mail-dm6nam10on2090.outbound.protection.outlook.com ([40.107.93.90]:51105
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229742AbjF2TkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Joa4ZjrucHKaj7cXIFEdSigtRSB5il5bAapsXsmWzBP313j2yQKw4SbT2QbCPqFBouwIZEepwsUtsLMaQETGviyS/vjSBx7yW3TJx9dtJc4GlEWtv2FYxrTR8pE6k63GtwVdD1EUiDL4FM2x4oq77RKV6JnTV3DdgwjJTetdNhUSwm5QtblUbwYfRGfmwACsEND2BUgYEgkWUF4zNy3yFlphVul4UIGBQaW0HhfUKkxboI9rimgSfvXTun0BGrZcP5ERncrPwlG0+dHnWzprEBmI99rKjfu5MA2iiGXN3XVKJcd7c1ghbWm6QcPiw2tBRuarX6Z5P5Vo9QNvbzEF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIWRn2+Da3yu9uiVYvGeI1cIa7PojfDx0sd9Zlbmb3I=;
 b=Cwt0iLrx5iprgigqu4yDZ9oVYChfqrihm2AeTYaDztnVeYk4jEORMK51PJYwr3ERoI1xjksPQ+tJJuTdXo1/VlzGgzmZDV0NLibQJHMYk9h2kTw3y9pjPwbCPaXxRbsgHDOoiV6qdZFyCGXtARd5c9qNEYzEhxp9OaXNfINrbUmrkyBXm+cuHs7gkRV334PklaKtDsDFWwOXzn01cWlVKBnnqx9DAe5S1CXsV2BIishRstm/BysxPtVkgkAwW0yBp8X6zYP3XdliViZgcSJ6TJ5GbGUXBbSrBHqd8RddkhNSFVWmxEb7vcoxFNmbH32IdhH7TLPVcQeidO3bygZf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIWRn2+Da3yu9uiVYvGeI1cIa7PojfDx0sd9Zlbmb3I=;
 b=D/n/CcmlZu9E30Pl899jshGs0MIYXVsZ0XXkhAxUdA4IqX8RWHUkw5xZfP98ZNAu+9e6l3bLo+FMtct67LUpvZFTRsSJtCt3aHqoZb1jaz6DaTOemw+5lNVNVwKvZUDWCPF9u/di/MarvAa5XNlCuQuAGUBHF0Ju+hkwlzs+B0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ2PR13MB6428.namprd13.prod.outlook.com (2603:10b6:a03:55a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Thu, 29 Jun
 2023 19:40:06 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 19:40:05 +0000
Date:   Thu, 29 Jun 2023 21:39:57 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-qcom-ethqos: Return
 device_get_phy_mode() errors properly
Message-ID: <ZJ3eDZcWUz2vBK6q@corigine.com>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629191725.1434142-1-ahalaney@redhat.com>
X-ClientProxiedBy: AM0PR10CA0080.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ2PR13MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: acf61677-15a3-4154-fe6c-08db78d8a3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJtRfInCWAIh/FSSG3XBbwBz86DkTwz59prvW2BT5KhGtHznHbA08pi02EcQ1jAeVlQD+7lGeH9QBYz1akTmzpmzqHFyovbdottlSuoZHHM5SCS6N883Sa/LJ7tj5jJidcLwOK8Xx8i7teoffOQ+86mp5sNoIcjdNLqGBxtdjDfF6hIXPL8qvAR4r3M2yxq6xw2jnpeAmEjzDqyN2akhLNeeJwErTzq1lE5prCRElZpeld0YgEzJs1FnqCtYAd+4EDXjSQENusvVisGPFonxRHeHUeFgGB/ysMHsUBA+JQUClzyflsPwcxDA54jnHz7nUm6WJLR16GpVw3+B0XbIo+dmEu1N8GroaLYAk4vTdwIyeu5RitSL5eq9ibWjhIQwukpzI5BQP856wB4Lveqv7QrNJzlMSIXAgftDYMuxff7RVGZKM6JF9RDjpHQjgte0b4p+gLumrjUSacIeVK+oJikBqHBWsR5pWpIEpnk3CIlLhR29K+VJduQl/uAUOddVWzwtyHXD2fEw3Myzjh2veYvuhJJsXMQAgWe77Lr+P9NLNi4qMlYDXg5WJSFZIXldIb0PdcYNiopDlN/GQWj7nCvs0HOTWVnFpaLvE3MKrlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(376002)(136003)(346002)(396003)(451199021)(7416002)(44832011)(66476007)(66556008)(66946007)(36756003)(8936002)(478600001)(2906002)(316002)(4326008)(8676002)(6916009)(5660300002)(6512007)(6506007)(6666004)(966005)(4744005)(86362001)(41300700001)(38100700002)(6486002)(2616005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmJ7URcIPt2U13F+L2ufAFBBjL6LMulZUEDQzGsdgyrqsF/S4x1w9XHT6IsH?=
 =?us-ascii?Q?XmP49cFR2cfjeZtvqXwB4KZf2Q+5+si2jIGn9Cy2mLnU2IhfWuDlDw+5ZUvD?=
 =?us-ascii?Q?bXEfm1tdLkAs7oS4he7xmue0nwfvHRMiuVNv6Bi0p/MqXH2Z74ItFo8RoPA0?=
 =?us-ascii?Q?bbhhqOsS5DXNsoYgyIEoH3m5GfKe6MCer/6pB6NQg5OUmfV3A1QH2MvqhpOq?=
 =?us-ascii?Q?CeDab2xEvJLKKLQLNVlOElEb+gKWqhmCsnTOf3IbNrKbX3TKIXl0V5iuGG7U?=
 =?us-ascii?Q?5qbImJXZ0sn4OcIofJZwLOsIXAypTiYHPgpcESNHlphIT3UtM5nbvfMk1UM0?=
 =?us-ascii?Q?DZ9WkfrjlipiVWfIccl6aLyy5T7sH+fVVV9P1yKeicE1DVgXRAnsjOfPr4C5?=
 =?us-ascii?Q?xRqjBPmSpDN4s/beMqengp3oLEP+PjoZE4tZhytMOKojn92uLl2fBQ9DgZZK?=
 =?us-ascii?Q?voJX4aQfml047roxnEnY1V4y+bvi8lU5mx7b7AMFf+nAjbRn1fN2aMyZpARm?=
 =?us-ascii?Q?4LfQf5x12+oLNl2tF8cxf7y0ZDOGv6YgZf/3Ica7oOaSvEtEE9pwMAwORgs5?=
 =?us-ascii?Q?Xljz5NHSIeEuBWncpRTnNhzNWGfxUhIViuIF9UxiQObhKfUAwk9OfLXoo/Bc?=
 =?us-ascii?Q?2/TCB3UMm/AVqmuhGSxd2L9ebncjiRUXM2C/rolNwkrqz9bCLpukRFSWJ7AE?=
 =?us-ascii?Q?9Xwe2VKnbH1791gywOuoOkLj6L3lUB3f4ADiKR+mQPfDsYmP5KMFE02/5Q8C?=
 =?us-ascii?Q?fggO9Wv4auZRLSjB8SneF6FVMV5UB7dJr7GpJWJL+AR2hArnVxl3MpoJzRGc?=
 =?us-ascii?Q?EqH/UpTzy+57k4PsJxXPKELbmQ575tC8ouZ6AyXhqrRmKpXvzZCzrUkRV8C7?=
 =?us-ascii?Q?XouJYWXrfBMo34H8/UN1QDWyVrq1TJIgA0SBHoJhGz5kiwSrlyfu+/vwccI3?=
 =?us-ascii?Q?ncyCDoRDkf3alkEInueKvEEdV+6Kl49dpaQjLluwtzSSsFWZ0bED3h+AHPhp?=
 =?us-ascii?Q?z9FskmfWnGmeK+o6BJ7F9BQDFCjAz6iotAaPVW9gbERARoNrmKjdMZzUPqlU?=
 =?us-ascii?Q?naxAYnTE3NHI6ttfXcxHE6AV3KoYtsA4/Ol6t6uIyxoF4pOTujYBv35RlzxI?=
 =?us-ascii?Q?C3eWu41UJLzWZvrTSkoQhCkcoZc5PZecVV4OlBXvqZjY64Z4lGB51TdDO3VG?=
 =?us-ascii?Q?K0feiQpY/rfAw3xzRJ/y3zUUpDiwf7HZumYluixmVkHLFN18fU+sxRKyLhvr?=
 =?us-ascii?Q?bH35zH32Gt1YbDn1jjcrsuzUz8gNnYXfWqtsYz+yW3Ku5x6rzdCT9eXUgBxe?=
 =?us-ascii?Q?Jmllw3KKZZA2igDHNLrncMnciYIXuijhLLjzxgZWpfcIq5xf/Yv+MSxdeqdI?=
 =?us-ascii?Q?9JfeJLZd7Kudkg621TLLMGFVf7ABSjlmISR31HOZ2FGDXhkbloJmBL77QzuY?=
 =?us-ascii?Q?kGfmRSjeCjrgK3qz3c+2CE/a8kVCr2UuuijGrli+b84233uOpvFJ8c6vrPw2?=
 =?us-ascii?Q?/zK0VS4Ftiunw3VKzY+ZfjcesQZUQxqGk5Pnsf9SCT1qMMcjyEHgsWNQK9My?=
 =?us-ascii?Q?x54K142YhbweWUVQlLabAk8iaLPnHiS7ECAmS0RG2DA7p3oZUQS9m/F5JeXm?=
 =?us-ascii?Q?Ku12kDdMfSAQSvem5ouq6y6c+wbov+rsHESJwniuAOwIMzH5DIV3PsipmvO2?=
 =?us-ascii?Q?uBIQ0w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf61677-15a3-4154-fe6c-08db78d8a3a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:40:05.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUqnLTaRRPzA+jJz68DbrSWo3OSU7OZECONr0KlMq/Kbp5O3jz1QJ/0AsdCqkOvRWYf4QKu/AZfC8JpgUH7imqlEo2W+QdGc6rjHO9oehEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6428
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 02:14:16PM -0500, Andrew Halaney wrote:
> Other than -ENODEV, other errors resulted in -EINVAL being returned
> instead of the actual error.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Hi Andrew,

I'm assuming this series is targeted at 'net-next', as opposed to 'net',
which is for fixes. In any case, the target tree should be included in the
subject.

        Subject: [PATCH net-next v2 1/3] ...

If it is for net-next, then please repost when net-next reopens after July 10th.

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

Also, it usually best to provide a cover-letter for patch-sets with more than
once patch.

--
pw-bot: deferred
