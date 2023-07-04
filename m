Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4C747400
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGDOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGDOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:22:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A7AE47;
        Tue,  4 Jul 2023 07:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCF0tumN3BXbr9W0EBTjiQHadxWtpFheadi5lFyMhTfcHzi6n+T8WUt06CjsaXmRDcaptqb36w7dUaMhzQlKTYzo7qtK/vOr1mUa5U3l7YygmGRUGRehcKUTw9HCDir7La7QtiAPlRPQtRYwQMRcFraiBfpgSIpBYFlDmzK0KPM9xRsU9jJrIhRb3BSEO3DrLIt4b/q1YN3wqfvh6ix5HuAQLJz16jCtCWKmbK6lOfx24363pSvo+jIngOJktyJKDAGuv7vYnLh4QollS63ZGtFnekNXJo0NBs8p10z52Ev9OdC7I806X5sBvmv0WSR8ohM6te7oMGHuTCnHD6+znQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb30hVl/dNImswCjkUfGBIYuD3068l7cChJS2aeUkAA=;
 b=U1kFNevJMD5PkenE4nR236mw7SLw4uSJVvoAIheAZVObYrkZl2iO18bb5UUbn1yg+6LlXWlLU8+Gb5bl4Baf/MPy7paNixNXArceVTPG76uoZkGYvmvYHGlQTjBWRgVIzMi4AabIuVQxwmHigihHFrdsK/4f8A54a6piCpDxQqs9QFhVNpC49R8tAGCXPcXSxP2cgtJH7gmEyhSQSfu7RgkNixb5I7VWoHvHNV45MEtd3ds4/cIy2XEPKWE6wpXeaBCwfz/6UA77JFv2IBmJqoActL5dX2fsfbQMPWsp0FPvPXRbecowe+Ehm1CvPTJjOT7BTGKkwMK+UAkkAQIr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb30hVl/dNImswCjkUfGBIYuD3068l7cChJS2aeUkAA=;
 b=MlTF5p19ZEyv6XG1cmqR139I77MdQ6KZHLY9GeZedlPCe9UNOiBjWgcFNUtoBC8N6FsduDIUVtNjfK3boROyVbOOGMAc5T0FGFXoIfu7xTASvlBFO5yIZh0TZF6Q9+mLI0jvJX90hF7+/rDcbrjcI5zijuSnzJVmVNVqkGP6E0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5113.namprd13.prod.outlook.com (2603:10b6:610:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 14:22:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:22:23 +0000
Date:   Tue, 4 Jul 2023 15:22:17 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-hardening@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: Replace strlcpy with strscpy
Message-ID: <ZKQrGaJzNlLse+js@corigine.com>
References: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a5cc31-cf53-40b4-f575-08db7c9a15d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXOtKNTgS6flqINEsQii/S5UGes310CTQLUrDjd7OXU5is5bptBqxFyQvvRoOYwnNo6fTUFIurZUedgP3VDJxzLVr0P3smgfAn6DZ6NBGk/vhWtTW0q5+po/a7a7jWfCJZyW5lhEWpAkHpzGDc0Ufrqq+IBV93YTAhEFUtZa9eyzPATKmjHE+FYe0eUcYb8PfdSlUNrl2DXYmbtstUy2bxvMbLtJY4F8+eVWyI1cgQiFIGI4go6tCrF+vUxOPuLtxw8iK/aVoZcXpyrAZa44rFSXfUTglrU1ZiS7xp1rfj+B1kZlZLJ/f1AEKiF/Cch+qNW2+Mg/3hbP6dKgYrtNm/tzpMX7QYgO0l+NmRA/wdLmiTh3nO0eEoTIzg0eJbIf+z+wvjte7/sAMg0SnaWqbh0rTF168nF7H/+x17qKV7v/qCSKtFQP4l8sLkhl108+XiUAaSgAvE/SlQznfbQamCE0MY3g8O1YNyB6MwI2XqEg5eq6rG4JRZ8en8NeFOoQx6QRoGLW2xmxgq1lZsNwBA+4UnjjzNPgTqVHFNAMJconQBcrHeNWiWhTaj88CHmKskyv3/hvi2jfjIdWUP5EtFB/6ixD0QZstu09muN2LZggoZ8AU1Mxh0MULKuPcOw1Ks3eusRvml5ZRB/Rgodf+bdmyCCgcj4qiE5KE3l5Wdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39830400003)(451199021)(6512007)(6506007)(66476007)(316002)(38100700002)(4326008)(66946007)(66556008)(6916009)(2616005)(83380400001)(186003)(26005)(478600001)(54906003)(4744005)(2906002)(8936002)(8676002)(44832011)(36756003)(5660300002)(86362001)(966005)(6486002)(6666004)(41300700001)(156123004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhy/uz2OI0hEVhfil6kn+VOvNq6b774DEnj+uBEGb2KOHnlGLxmzCBVCiPPc?=
 =?us-ascii?Q?/i8IEaBlF/nxyuE9zaBrkPdQASIfIFQA+1hmQH9wiJhOiFxbPmELKil0JbMQ?=
 =?us-ascii?Q?b2Rz20oxvsHBsajUwODyrsAR2pftD1tIjp7hNsdDLprThATtZKh0qeOlMA0w?=
 =?us-ascii?Q?imkUuIRyOIk4sd/nWg0hL66RNFDmUzHQ/MM7kXcUx9rkH8X0fY7Ptci7kJhs?=
 =?us-ascii?Q?hS1fK+cp7clUJ/eMiqZGYgMj71lINHdlSohwEphOXULmpHXgZJ+h0BOrFfHr?=
 =?us-ascii?Q?veoH0szuegkv8o7WOkvyoXYprh2HlwmIyk6TsIVa0xZYfmFKOtkAUpUNEo0c?=
 =?us-ascii?Q?SpkLh9LVFv98VqNV3IQXAys0BbAA97+KaLQodQ/LTrhLvL6EXbl0zzvJo5zO?=
 =?us-ascii?Q?pI0JN+opipniY8Wfc5mEuVgoZunq7DOC0x5B67j5Uj69pp2ygaSknxTEqVbQ?=
 =?us-ascii?Q?zoT0P9/yTzw71ZRWw45dnY3zhC2MX0UBwMmV0yp+GoSDT88tUlPM+2CLxzKe?=
 =?us-ascii?Q?Va1Q66XoVghVYXsl0kUtLM0OUhZa57jZoUmIJTMjVhlNrS2Mn7y008xn2Mjn?=
 =?us-ascii?Q?qJPNSWQTRy6YOV3I7EXul/+nif4DW9GXUSyp2jUJuZfwbgf4CzxIPHig2Av5?=
 =?us-ascii?Q?CkyvpfS7vlH+JaL+QEzkIOjpvQ39Q46U0jHbWkgSb3DHEyXc2fjJCG+cskeK?=
 =?us-ascii?Q?FPJehLw7jD04IuGu9oMTts5nHFveDZlQtYLif5pzENaeJKPOPwuAiYohZL90?=
 =?us-ascii?Q?uWCnjVA/E9bvTQV2tPM9NbxmAh76GmMMqC2HdKMfqA/92/zYLauqVFtwQlU+?=
 =?us-ascii?Q?816uMAmYzcQQTCZZmkPQM0C/zDuL8rpvweuu1P+YZxKwCr3hKncVr8DO1CW3?=
 =?us-ascii?Q?PxAqF0UgLrL94meDKIUg6GfRA6XWvntGe2NleDjlN6R+nVgKALraPuVTNtdm?=
 =?us-ascii?Q?3lT0kzBQiYKU78igwC7J0PvT1dZyTHOHFIIZH/4T48404KXvR9CDNs2IiMnf?=
 =?us-ascii?Q?Ytl57nCK9I+7v21rL3z3aHhpF3cb3dWpO8L+V1bQmGS6t/YB7CQRtmV2BizL?=
 =?us-ascii?Q?oq/tOsCYgq6C9f5nZLJa+/88sHP0FHMIJUxLWizI2ZNyd5Knb1yvBo9TbJYV?=
 =?us-ascii?Q?ARkY24hO5hwrPr3n3eczKdDx9cic+7pv9DCGM3jP/qqYcRxsTBmKV942Bul4?=
 =?us-ascii?Q?/+pvPe9VGEf4Lotjn9xYybTaHfLNILk19x/m6RYLeEGnbGagf7sghxRxvj5N?=
 =?us-ascii?Q?YhQvr2bfWwW8s9t7joL4HakQBK0jlgIjH8Q+zVtsRpJ0ac1/Zl4aDQkRHzAb?=
 =?us-ascii?Q?DXS39Bu4bf8AApLZWhy60L1peYCq9za/sKnJ7PkJ259LwtAt6iuT7er1z9ts?=
 =?us-ascii?Q?RPgrOE5T8jyskBLj2JRqU5zv3n4Wh9FuX9J6B+I9Ygo53BDEjBC/LcCzILYK?=
 =?us-ascii?Q?LAu1oUUqamaQspW/Rg4Bp66Jjg30x6jk0RK1ZX19EDpA1+SEwu3Q/Hg5fhBo?=
 =?us-ascii?Q?JhrF5jXldK0Rh+LxcQpEAkPU1XlNLsIF2QNQVGQIF0KDD+QnDd2HAui5HHro?=
 =?us-ascii?Q?DE3HREY14kfwnks810RSWut3T7GsK2zn/ZHC75oAaNpqBchALYgIlH14lXep?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a5cc31-cf53-40b4-f575-08db7c9a15d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:22:23.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxx2Rbyk10cvuRcLWrQz7aahoglUVq8hOMGf2OIG6Vjnh8AXpik3MYFRdo1Zs+d9HLASB1zbpqD2eQVTm8YA+7rpYO7W81Glbe7S5AZjK08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:58:40PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

