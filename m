Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684966EFEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbjD0BB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0BBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:01:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C983A92;
        Wed, 26 Apr 2023 18:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4o0Ar3v2vd+CQeyu0Fs9U6lkjHgO5SoPIg0Wk5Imo3kd+KHUWOWcKZLnNLaUr/1nTlGrvklYp33n/hA46G0Kdzv+HRPf0q707t0q1SBOIzlcJkHhw7D1p+VNbOIESOynvI0eSKn+b2TDLa8/KE+TLpg0/mSx2PFvwuDORtfkFjR572URPfDHLemD27SnBPoEX4zCSIcDCl8ilB3vYafj7YaphzNJ2LjDDJ1EiknAUUA3QK68iOFg0KxUsio7pgVlFlQKjZj8AhqXv7N6G2G5x7YtaMN8JjH+ZWKuyzPtKcjzriYRymhJx2ERwSLzdI5ThmWzd3mEHH+VLk96j5EXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWvIQfFrKED3a8bPL/biZTNzvOLUkXx2VH4tDMdecL4=;
 b=DRjIJaQBbMSNzYJYmyt+ih84u1MwF42s0bDtM1GGQ0qOCFkj9kYwG8DyhHKPZalTKv1Wd5YAwaOvfvTGe/NPGue2NsJ3btXGOsJN/9dIoWICfCguizizdz/lIPlmKtXAmGxqapnJcNKplfb15ukfgc8dQ/bygHx/KYlxoc2bhKzEnMbD7wr4IhFMqPC/90UxNysosYzZpxS4V5GA9iRYw2XnIyZ7scyOkooDGKFP/t04eKUIg1kUE7/RtfTHwhUSjMfvZK5o8k9vJZip/2RAL9w8Im8NLUHcOnSI2WKp7nbjQbJavssTtuguMMD9dD65Zj6qL/nDqNR77OkExl4rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWvIQfFrKED3a8bPL/biZTNzvOLUkXx2VH4tDMdecL4=;
 b=MH/A5ssLMP8cezVYRRdbOwvoOf+ZyzOeCdZSPIkBpMGKalEZ2bGW4txLRqswobGKf4dsgILuN6Y8N0WEdydaOpOtYZIDm7KlvQyUasKF/y0dvzYGSUjJQn8eLCA+1w5IeY+D79TXY214OSOpx+FIjUWQMquYksPZLCmCkj7Vs+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by SJ0PR08MB7767.namprd08.prod.outlook.com (2603:10b6:a03:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Thu, 27 Apr
 2023 01:01:49 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 01:01:48 +0000
Date:   Wed, 26 Apr 2023 20:01:43 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fei Shao <fshao@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: input: goodix: Add
 "goodix,no-reset-during-suspend" property
Message-ID: <ZEnJd5ph4LCGPBwF@nixie71>
References: <20230426144423.2820826-1-fshao@chromium.org>
 <20230426144423.2820826-2-fshao@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426144423.2820826-2-fshao@chromium.org>
X-ClientProxiedBy: SA1P222CA0131.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::12) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|SJ0PR08MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: f36838a1-a2e7-4e25-cfeb-08db46bafa94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8LAhyLxxyrrzPycQnIQ412Wy3FDaEh8d69eNauLSAGL+g5m12uvsQf/BCpNOYxuyxg5lbTwyLVfxNJGL5bOPnPE4Ci+3weNkS3QEycsFfiicqgdO03LYIb2pgOfyp9q4tHluCpTCOGYi15DiIK2W4Z7bDTZEX1Q7w1JZli8cnVAENLeT/htcJ9yiI6FzefooKa8TXzFhHykoSQkn+JXfvRCCvHK+75n7QLDfyJjKDhUOebTHhQ4DUsOSXbcC9jqWcWQt1tsQ4/SNQUXZpEdPCC0iGeoznod+X7fe7KfpHViPp0aRdW8DQurVKb5/yHSYhQY029S7pp5SdWawXKhefea7murg7QLmaSCvZ5hqp622gwcmrMy2OqpVfm0YKvIQLjbYJO7cc3vB4tPWNwLOQEwCefkm+mTCfs0u7wTMtvEQae0NgpenYmeAngFJUT15OyhGdNMn0jcKZsHjkgl9AOEyZw0VtwHRFh1N0KCoNF594dJgaqZxlc4N7yp1Jga/AyGKYJUGRDozCnfJGy+RWbFx9y6uRenC+tf7DvKb2IUu10atwLK9pyjzq8cKP9o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(136003)(346002)(39830400003)(451199021)(33716001)(186003)(86362001)(26005)(6512007)(9686003)(6506007)(15650500001)(38100700002)(5660300002)(6486002)(6666004)(83380400001)(478600001)(54906003)(41300700001)(8936002)(2906002)(8676002)(7416002)(6916009)(66556008)(316002)(66476007)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQvi1j2XkgTFeMX4Btg2Rp/0P942nVpk46hwdSR58aNTAsaWan2u49r7JwXg?=
 =?us-ascii?Q?aSWGBmXQva2D4PCqfHLkapsqhNXj22dj8BNJkvs6bxY9V838i3+z7t2kn4A+?=
 =?us-ascii?Q?Jfrsd6SdHEZd9ZyVaNeSHu9hdN054lqwjEEATJ5oPofwCRbd8MIl/mo8tgXY?=
 =?us-ascii?Q?zOEIwPpy3DjRCkKdsnqazSYS1Mmh/G/CjZ9UVvOMfLn6fRB8RgdNQWYsa/jE?=
 =?us-ascii?Q?VWuOX4ejn7BQelLPAq2vsPf2T60b4KpSuXTMEQLHIqYp3gdlduIE4vjlGZXe?=
 =?us-ascii?Q?gWWZ/rykWyMDNyVwLx7MC30Hr7skiadKg6HwBCi9DEWaZzpqH6hfF7Kt572o?=
 =?us-ascii?Q?77CO9ptsZr6UEko3KCQAJTqSlYmvyVwypTqxD8OGMSmC4ye6DwLEOy2kjElG?=
 =?us-ascii?Q?dBoKvWJDlMKpCvZBHO1YSLf5GklWNY2Srj5iEN+gHkDwbtlt3wpsVpaY6LdJ?=
 =?us-ascii?Q?kykczeprV21T4/OZnWA8Vl6L4iUwed6K/IhwROag8n1Ok076cpIsAGroyYo6?=
 =?us-ascii?Q?mUvqCZCXGukIk2Ok/4DK5YOL48gkbNRBNsw6hs8MMTyf8qbOtfiJok6CYtSM?=
 =?us-ascii?Q?ylsoKbst8u7vqbW/cH1WrTKn/7ijS/XlHC9OpHlTi8r24eEVg2AX+kQg0Rms?=
 =?us-ascii?Q?AtVyq63cvJkAEADvF6O1XI1y8U/ZqMQyjxnILGQJVjUVXUqQP9QwZdoy81S6?=
 =?us-ascii?Q?yYgld10lziBkgC2bt5ACWbXxeJb1xqSxeoC/aYh4pKEg9fItfJdZUWCM8cxC?=
 =?us-ascii?Q?+cPK3mxjY5B8C6QJqljOonmSWlqJtA7sW13Gc2OeWbzET3QHr7I32uChrqoX?=
 =?us-ascii?Q?yxMuAfOr0+FU3m5QSYEP4uAHzLz3+q07eTM/vB+OJVJbYTSeWkPNgjQJj3Tn?=
 =?us-ascii?Q?2AwkKaKTPyMW+bPr3tLFAfF6L2jlCg5T3AjoRxyCWyNUjVngQaDGxuK8aXW0?=
 =?us-ascii?Q?+A1otKmgXNN7/pj4DoaIaQjwl2Vg/rjD8U+gfAS9LAIfj+YmBbCGGm4OMAeZ?=
 =?us-ascii?Q?nPVXKuGndZZDFR7NUKiL6Rnel3jciplKxeGAS3YQsaQR9xPZAxh+HSBCEsom?=
 =?us-ascii?Q?V6w0nlXPMKv0YYOqWrTuqazqm2oAMMXwuUfucGVBjaY/UFAnFWofMqLfI+40?=
 =?us-ascii?Q?2VXmVW4so6HbZ8HHbYbarBWJkbid0+NwLK0Gq4dU8s1KuYXiRYQ9Lnu2xBhq?=
 =?us-ascii?Q?DaBwWhcaSpTugAnCg+pTetRYvFJ25bkSb40obEo9S4akAqrFmB8TBKlA40Tn?=
 =?us-ascii?Q?q6SdqVQC/iv8r6pyHWurpM2Gage7XPeS27a3j1n7ZY8mcJVBCXRwtp/SLMAP?=
 =?us-ascii?Q?2aDuyEukuBekxNILZLa8mUWDtAlIFComcRifLwUpAWElDQXFbfrCZKGPUpfT?=
 =?us-ascii?Q?Yh8o67xZaFnPC6orOzGTN4Wpk2YPDuK2gXg9NdMEoSh6UvxqxvMNXQVfm1ag?=
 =?us-ascii?Q?0o+LsbdZ72rBPLXf0I+VKVJdECR8tU35wwT+wXKz8iUJSE+AuaQAWB20qVt2?=
 =?us-ascii?Q?Butyyatc2Ak3cXI9+NhEtDJmhsPc8duuupKYmWPRXh2+Pqldt03bLya4B6yx?=
 =?us-ascii?Q?+ExJUfj39gdIw0NigVXtFXt7/Nfn0Cf+jpApA+N7?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36838a1-a2e7-4e25-cfeb-08db46bafa94
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 01:01:48.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KkBapo2dR/DBk96RZmE//+qMIxaPhMYbfHrFS+I1Fp8GQoeJsKOPNl+2/c3E535MkzCwcWFdquGDtqf9zpKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7767
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fei,

On Wed, Apr 26, 2023 at 10:44:21PM +0800, Fei Shao wrote:
> We observed that on Chromebook device Steelix, if Goodix GT7375P
> touchscreen is powered in suspend (because, for example, it connects to
> an always-on regulator) and with the reset GPIO asserted, it will
> introduce about 14mW power leakage.
> 
> To address that, we add this property to skip reset during suspend.
> If it's set, the driver will stop asserting the reset GPIO during
> power-down. Refer to the comments in the driver for details.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> 
> (no changes since v2)
> 
> Changes in v2:
> - Use a more accurate property name and with "goodix," prefix.
> 
>  .../devicetree/bindings/input/goodix,gt7375p.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> index ce18d7dadae2..1edad1da1196 100644
> --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -43,6 +43,15 @@ properties:
>        itself as long as it allows the main board to make signals compatible
>        with what the touchscreen is expecting for its IO rails.
>  
> +  goodix,no-reset-during-suspend:
> +    description:
> +      Set this to true to enforce the driver to not assert the reset GPIO
> +      during suspend.
> +      Due to potential touchscreen hardware flaw, back-powering could happen in
> +      suspend if the power supply is on and with active-low reset GPIO asserted.
> +      This property is used to avoid the back-powering issue.
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 

Many thanks to you and Doug for the informative discussion.

Kind regards,
Jeff LaBundy
