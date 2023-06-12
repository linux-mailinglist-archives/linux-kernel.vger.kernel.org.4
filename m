Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724072CBF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjFLRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjFLQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:59:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C319C;
        Mon, 12 Jun 2023 09:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR2fJs2gQZhUMrHGWh2EK/LZdGs6BvjXCAquopyRhDUGQWKrFhprfdwcWGOdwIWc3cCmMHkDu5fsMPLFhlRrL+MD3JfbqDHMRcBVGxT77R+DhELHMXx+Wt6DgIZoUphcN4FNVGHjT31RPU4EQEb7IITjIsFV2V/wLYpDfv/bcJKYlLeXqcDP2nDlJF/dNtosNuHexjfhZYosZtTlrXmFCUlZt7YC1PJe1DOWXuhhB5RxfJWL1i1yBHHDm45UYaBk0mjgsF4UWXB1wDhf9bkc7yJzZ6e82KNRlCi7/9CZvnb/m2lGIHwmQejQPyoBRqzekg7aXg9ouU/x9PZEUNnDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl+3ADOcGPQxCXqIRNjk7DCGayO0YDZizsM0BCKnUgk=;
 b=UBCaAhVqaCluJ19QDPQog6OkGbth0YId5KWcAoxfB6j15QaExFFhWYSlbT6AGCGBvrwOh7QiuBqVoj/gLDKtoSD3vaCTMHbosMmkr5FT0oVxnH3lddjR5GozqmBtssAQX1Wyvz9yYvaqPmwxOKgK8Fd+jnKRadXqnPmoGhT5OBIeYiA/vyWlOys3oeZNxlLUc0uFW2eaMdQUqWID/pHS5tjHpXwOJnlMV/UlUd7ixdEM1D2v00yMPUzLWyVt3KKlIBDGbP8IptSwDRoA3+CGjPDaCG9fWlA+yN6Z1kD4KbITkt/jZZ1DpzcLzCekYL36Rgzww4dpa3hSZLEyB81GBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl+3ADOcGPQxCXqIRNjk7DCGayO0YDZizsM0BCKnUgk=;
 b=IEpP9u26ehFUUrbZI2bdQ2VvdYyLOxAYkT5zsf6n1FGT4LtHwRoLdA2K+DMOQ09tYrn2gVh4KfL7x0MF8RYMF+jbkLn3xtLwK+86g0EyKYbF0PXGsue9OGK3tYICAcrAA0jQw8PLOTF2em/EV914uuaCrtdX6tQdLb8zigAjIjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB6616.namprd08.prod.outlook.com
 (2603:10b6:510:38::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 16:59:50 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 16:59:50 +0000
Date:   Mon, 12 Jun 2023 11:59:44 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] input: touchscreen: add core support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZIdPAKqSsbXLrqHa@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-2-4a0741b8aefd@linaro.org>
 <ZIai3KaMmuAbJB3M@nixie71>
 <3ad327dd-cefd-b195-2d64-6d6afc2d4283@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad327dd-cefd-b195-2d64-6d6afc2d4283@linaro.org>
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 881277ad-7935-47fb-c43a-08db6b666f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9ZUlZ7eZgzQU4zqxNjIb/ii0B9O0L1faObcj61MUal2kZqT/ENIWvxAVYj9KhsBo2FcGBYWHoKSpT5ekJTLCX+ATm9kupgF5Feog8WHRzELcW9LqVUnO3oHiIh2N1aLYTnMv1sGPpsNGe3E/u/DM7NHNiPZMgYvdEO9iPMYhEHWmVNNywdlF6V6gbeKCW+XFmCqKuPm5fcjfKxgj8d3Xw34YUDFKcgSXOoFj9oGMNkRo/0g4G6QdhJfRMi6uEXEp/JhxpLpKuDZXPXkJgynIVMTSrBIH7f+N2Fta/rRsr2wILNBIpDCK/azCB0HN2Xj5yGjrOSur3RofJoMaXD1Re6qCPcfcWfzeoHnVZwGoOpPiNvJKd1LgBSV5Cr84g36N+hOSuT6DS1yeZUg5VW2pkGRXCsGkTRdNJtJCvRyXNU3QekUhrd/iP9c1mSK23btuGww02yLNoQvzzU7G+RHv2FhhzwfAddSqMI1ydfyU/8/ReDce2qfmnPXmUDG7mJfVJF5SPLyfLW6M5SezMiATg5+/RscVszrIFQj7zrN9oBrsS2G6jcOekFmqmjvHu9r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(366004)(39830400003)(136003)(451199021)(316002)(6486002)(41300700001)(9686003)(26005)(6506007)(186003)(7416002)(2906002)(33716001)(86362001)(6512007)(38100700002)(8676002)(5660300002)(8936002)(66476007)(66946007)(66556008)(478600001)(54906003)(6666004)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewWKLvhBABKsY464ApFEbu0N5V8uWKBXQaCGPUpP7N4J8vTXVy3OnJyCj9Qn?=
 =?us-ascii?Q?W3iiOZqJFABLhOQq+kePefkq5U8EUvuFyLC2ROlErz+Z5YI6gRC9Rt8IW7dv?=
 =?us-ascii?Q?VuQ/9GGXVmObD0mRYzvrdFZ4Pgjuvr+mPHkE+BKyMboKIFDYOuPehW4c/ICj?=
 =?us-ascii?Q?Nz6pH6H6ZyIMTxzheRkP9uZK9l9nURhy98Fz1ZcpYDWfjy0/mu9SqhrSwMzW?=
 =?us-ascii?Q?zGSTOOEuhu41jexujVPE6wU2s1nOaSBdBWA69+RbPvxdDn2vTI6M1V86NnzE?=
 =?us-ascii?Q?wlMsWl0OWijoZ2OYOy5yKJPc7znx3m+1/gjXGO8+rrRq9Cw/Ohpr1cRLOV08?=
 =?us-ascii?Q?BVdhQ8zx051flt6iVqhHR26G5snM5VLm480zdBww7bOHIbLGAeSqsn5zSlq3?=
 =?us-ascii?Q?shAQkFciYDtwyZj0BjJmMO2OtQInXXbKb6rsIZLKMIlijeXsGu94LT4u1IV2?=
 =?us-ascii?Q?bz08oKmBNx1Aj1xSig5nBRyfYLdN+CC0+mek9xc4RzW05XniXgMUrZ952PqB?=
 =?us-ascii?Q?4pT99inH66Ufil331P4WHiSLW/PM9aF8mkqjWJJUE+92FDi/TpYO8GDQ0jCE?=
 =?us-ascii?Q?qQTiUbSwTRiXMifNI8Xfde70sbPjJfUPEDPB5PXerYJAaCiZQkLHYPbyrS2Q?=
 =?us-ascii?Q?LQpB77/Ez6B8EaSLUCsu0hxewbzTy5VgKMejb44/1lJg1mxz0FuK5s3FlvsC?=
 =?us-ascii?Q?ptLqMKUGNH7ykURyYIdP0oSzYm8cqiBz3ZAQGyQS8sMuxlo49Hg9XfyOvC9y?=
 =?us-ascii?Q?531P9PuiU//EFD812DY5IBiK7ORGJBlPt8O2VqRKXXhxw4sjZjOvkYsaAKWK?=
 =?us-ascii?Q?H6Hobl11nl/8wDmOdi/Cn+tGjrKrX6HB4VjuSKQk7U+GlQRY+XRj91/wdtgZ?=
 =?us-ascii?Q?0QWv7m2sOlS++uCB2tKtRpNK02qaZi1GG5Mrcegywl8C0Ur8enAaF99ICwa2?=
 =?us-ascii?Q?gMXqFNy/ivdI41utH0MuXNqybjX5YvsEm3BzJZeL+nngpIXDz063GWS2oIp7?=
 =?us-ascii?Q?BwDiTjkx3kjuE1gkx4fJNSiRfRYW+kk5lxH6/u0mCBH25qRXX3SBEKyr+R6d?=
 =?us-ascii?Q?MnnWHCqXurcmNejrWa0dNGFkD6sbLwGnPTpFgX/HunxBcX307sJ9fY4yxNUZ?=
 =?us-ascii?Q?x/Ct6mSmq/rGmRvT0RVPmVK7MLmrrUktuTMAJSUnpPRTc7eN50KfaFv/CMwD?=
 =?us-ascii?Q?OYVmjabWsn3lkSGaqQrBR8mlHKQoCTN2XQx+hJoSbUIr+ry+aOZ20g9oV9LE?=
 =?us-ascii?Q?z4Vt3AvNe1c1RZyDhWmASnO+WkDVTh5+FUVBoJYsTP5F25gKanEgAg4QJ48O?=
 =?us-ascii?Q?xIMQS88NN7Fc3yqxrVqFcd0Vcr0aX0nuhJ4AV0zNVtWg3OoBvOu/uqTjjxDz?=
 =?us-ascii?Q?yqJHkXHEEaHxzdVnr3pmqTbIDeDHD1jDjzEm6CGWdLQRYKnExhhV25/wqLmI?=
 =?us-ascii?Q?ACeNcnG2/gHf3ajPJNF+SFK7rfk05BzF3TmD0Gye3pBPf8wvEMZzlEpUC7CZ?=
 =?us-ascii?Q?73Dtd97QR+KcgM3Kuo6W3m1lYJM6v1FQN5+Vvd/odzdkDRSLBa6O7WLeeo6y?=
 =?us-ascii?Q?FomNs3gugoFaAEl1o0J5Bb3cjCm/aQu6NUdIO+2y?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881277ad-7935-47fb-c43a-08db6b666f34
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:59:50.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsMY/is8G3WjSODyEElbmp8hLOH5Yj1tHMGsc4utq8XueEy9Lx7+No5viPj88GgN+2nc7d5jquo2KKO/5lZwfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6616
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

[...]

> > > + * - PEN Events
> > 
> > What is "PEN"; is it "stylus" as written elsewhere?
> 
> Yes, they use both terms in the vendor driver.

I recommend using a common term throughout; as written, I first thought
"PEN" was an acronym.

[...]

> > > +	misc->fw_attr_len = le16_to_cpu(misc->fw_attr_len);
> > > +	misc->fw_log_len = le16_to_cpu(misc->fw_log_len);
> > > +	misc->stylus_struct_len = le16_to_cpu(misc->stylus_struct_len);
> > > +	misc->mutual_struct_len = le16_to_cpu(misc->mutual_struct_len);
> > > +	misc->self_struct_len = le16_to_cpu(misc->self_struct_len);
> > > +	misc->noise_struct_len = le16_to_cpu(misc->noise_struct_len);
> > > +	misc->touch_data_addr = le32_to_cpu(misc->touch_data_addr);
> > > +	misc->touch_data_head_len = le16_to_cpu(misc->touch_data_head_len);
> > > +	misc->point_struct_len = le16_to_cpu(misc->point_struct_len);
> > > +	misc->mutual_rawdata_addr = le32_to_cpu(misc->mutual_rawdata_addr);
> > > +	misc->mutual_diffdata_addr = le32_to_cpu(misc->mutual_diffdata_addr);
> > > +	misc->mutual_refdata_addr = le32_to_cpu(misc->mutual_refdata_addr);
> > > +	misc->self_rawdata_addr = le32_to_cpu(misc->self_rawdata_addr);
> > > +	misc->self_diffdata_addr = le32_to_cpu(misc->self_diffdata_addr);
> > > +	misc->self_refdata_addr = le32_to_cpu(misc->self_refdata_addr);
> > > +	misc->iq_rawdata_addr = le32_to_cpu(misc->iq_rawdata_addr);
> > > +	misc->iq_refdata_addr = le32_to_cpu(misc->iq_refdata_addr);
> > > +	misc->im_rawdata_addr = le32_to_cpu(misc->im_rawdata_addr);
> > > +	misc->im_readata_len = le16_to_cpu(misc->im_readata_len);
> > > +	misc->noise_rawdata_addr = le32_to_cpu(misc->noise_rawdata_addr);
> > > +	misc->noise_rawdata_len = le16_to_cpu(misc->noise_rawdata_len);
> > > +	misc->stylus_rawdata_addr = le32_to_cpu(misc->stylus_rawdata_addr);
> > > +	misc->stylus_rawdata_len = le16_to_cpu(misc->stylus_rawdata_len);
> > > +	misc->noise_data_addr = le32_to_cpu(misc->noise_data_addr);
> > > +	misc->esd_addr = le32_to_cpu(misc->esd_addr);
> > 
> > What is all of this stuff for? The beginning of the driver explicitly states
> > that ESD recovery is not supported; please consider stripping all of this if
> > its only purpose is to support noise in the logs or sysfs attributes that we
> > cannot reasonably react to.
> 
> Those are all the firmware parameters used by the driver, for now only a little
> are used, we already read the entire struct so stripping isn't an option otherwise
> the values will be shifted.
> 
> We only print those over debugfs se it won't fill any logs

I feel this is a lot of bloat to simply enable pretty printing of register
values. Some of these struct members aren't even used anywhere; others seem
to be related to functions this driver does not support. Do you realistically
expect one to read those values?

For registers that customers would in fact need to read for debugging, can
you not simply rely on regmap's natural debugfs facility? It seems you are
largely duplicating that here.

I understand that some parameters are used elsewhere and it may be efficient
to read the entire memory region as a packed struct, but there is no need to
unalign and store what is effectively padding in many cases.

[...]

Kind regards,
Jeff LaBundy
