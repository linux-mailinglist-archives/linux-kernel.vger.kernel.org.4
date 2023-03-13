Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6776B7EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCMRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCMRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:03:49 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on0711.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe15::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52645CDE5;
        Mon, 13 Mar 2023 10:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cML3ib6q27+G/IooFayVY1W2z58cRG/zEjnvgIYNs7EvTxBQGRwJvU40BR2sueFNC4UHtv4Tml9/xMN4G26gCfGNexlyHFdzpAc32xo6vQyua57ostNYFnlfAqW4cujXIF+/dhm5UPvm37saoXgdVZvvc0+5/w6grckZDupWvUgvGhdpahcSmK9xQjBT5OIyctwAu3UmgfJJqmjQZYzh0qDR2cfOtk6Gsju5RyoL2Orx5RwKgedZEkwAyIk+DKckm8nw940xm3IWbzAfeYsPvy6oXYMsbpGkBYmB45tZUmp/K5jg4smZMZJNiOViGF4YQL3/8HIknOCSSy8RYOWFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IaMazu2wE8Y5R2/e/pjFvlwSFlZeU4J57m51qZiEvA=;
 b=NVQVOODhDA3OY9K2fX+DMGAiELyZXTM83qSX033xjzDQlQGjTYxt36JxU7d2x77fcoYn84DT/sEqOiYg2Oq0xfO1LjsxP0X3y8FtgRMRUBAXi0reEflG/8kJBFwjfiwbinq59Y7U3+NPGiBdrdns9VHhwVkBYUqpZi9gpxE8MKy4uTWsOc20vxLruhte3+r1ZElBg47IftIzIt13ab59mtcpoV4/KW5qfp363Jjq0acCScPH0f0PDGSXJrSEhhWhysmQpRK7ityhL2lrxwD/HcvzohRxpnrDUZZ1VsmDvS4Pg8XmVfYE3JMzy+2e0G4lTRdCw81tqcAFlNL3jzjHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IaMazu2wE8Y5R2/e/pjFvlwSFlZeU4J57m51qZiEvA=;
 b=uJZeIbM70qqNFlrIPZC9cSQ/j0pEjzlvDqkgCVwYQAR5+uyO3cDh1ZD/6jGDwGtzzQrobEbxC19OAh6o/6459ZFhF9WnNbvJkWanqTNlMOlzANpRM6TBS03y6fTf9pqN0rG/WCjoUX50/h4Zw855Xy7EOKFET4pdCcby/f2GwYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5796.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 17:01:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:01:36 +0000
Date:   Mon, 13 Mar 2023 17:01:33 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Message-ID: <20230313170133.36dff88b.gary@garyguo.net>
In-Reply-To: <CANeycqqBVyDa=e+heDM-Wa9Bz30PESdMJ8Eu0OCPLh4Kqv+xwQ@mail.gmail.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
        <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
        <Y/idMBIOfFZxXnVM@kroah.com>
        <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
        <ZAnB/DozWsir1cIE@kroah.com>
        <CANeycqrtjKMfpae_DUp-VrDZugJVO7mcbBvUBB+zAc=E6aU4tw@mail.gmail.com>
        <ZAoTNlF+bHyyGs7x@kroah.com>
        <CANeycqqBVyDa=e+heDM-Wa9Bz30PESdMJ8Eu0OCPLh4Kqv+xwQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::32) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e06877-f0c2-4d70-4cf5-08db23e49ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hz5uCVdBWtfhDe+RzGg2arbF2+FdoxcmCEdGl5xXLdDzoNS2Y5TueCAsWPH7kazOEGfKzpEuafxMetq/jn6gXd+QnbX0qrs8q4kG3XSy7sIlLJgdsQNZXc5QpFD44m4omMK9mTY3P6Yia8333VlVWc04hwdoRIOOT/txncPkEY4QaqPezyuDFIwI0g7GDJrZNEiU9qgjGZPrHjOpgtyBevveSS+GpuPS22LahvHNKwWjaS5dpu8wWPrTnNzNMUdg44j9Va5ocoUtX6KQ9/r87LrE2olb1PC0iAzYLckyhQbmG7SWjhCgOBduR85s4uQhyLuLbmxTT1DaGAF19d9JWtqnZkUpZ69Ji575SuEm61jjQV1ORe2atWGple1ufUIP2YvttnmmYj/Efj0/RH7CTQsDTXufRTFBcsJXtHuEaf0Lx492+cuEiaFzKcd2VkDeySPSxarDSFf4k+zn7im9KKeobBhq/H7QAm2I97ys8aYMvD5LzyZ+XjVlLuKlrW1n+WZWy5V8qaxIa5Qn82HGmaP74Wj0Alo00XiBkfS9x3Grz03q3BOQu1t9mxpX/NfBQrWWwPZNvwwosNlEx7M7JIaMcNj+QzGbPJHb3sYH7TzlMTyznEeDVW/VcL7IetR/3akcC7hUsRHoLItM81qIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39830400003)(136003)(376002)(366004)(451199018)(2616005)(7416002)(186003)(6512007)(26005)(1076003)(6506007)(83380400001)(8936002)(6666004)(38100700002)(5660300002)(6486002)(66556008)(66476007)(2906002)(8676002)(4326008)(6916009)(66946007)(41300700001)(478600001)(316002)(54906003)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ix2+TM5G9aZq+ZgngbhaIo+jw0RcpLACW1sSqZjahaDQ+PWOnCJRngxXbpA?=
 =?us-ascii?Q?SsaXzO/wYrF1LybfjjP1qRja+mv6FKuzZC2mnFIhtg/l3STakojHnMmliREV?=
 =?us-ascii?Q?fx/z/wXX7WHSBAtdE25DOoAzFfSw0vhwfbyEnBr3JZ8EjADTgSszt0vKiJ0q?=
 =?us-ascii?Q?gRhxi01+OWto/+GS2/YB5qIWeUXjYmWEUiwCym6krA3xS8zx4m4yQSgt1jFv?=
 =?us-ascii?Q?ppYmcEYRZvauMvJLDgssM6v5OyxCqSP6yR4IJY+rwFd1SP3zy90wqwldU1hh?=
 =?us-ascii?Q?u8pfv6XEdL+PAqcv4egWnTHMC4/DhJe0Bilkh33RsXdfJYzCGcUvVKoOdqRK?=
 =?us-ascii?Q?P26oPqgejBu2PsRtv65icHYC451eYDcL1FnXPFE/KNWZ3P6EKJIPtkW4xgPy?=
 =?us-ascii?Q?7mUqXKRnHXK/IYhJC3r1iLtje35a2zw1HX2rNlKyAUdm/vXkepe0n8vm4t/z?=
 =?us-ascii?Q?IWFxI/lZsHMJBkJAkQTd53d2BMr/V64avk7kijuFSIwc+zrXVamDZD2StP81?=
 =?us-ascii?Q?rVLyY7pKiq9E+DLiOrfkPgUukYZbK/7N8E0lpBBr8ZT+XFEr3t7/UxXBgid+?=
 =?us-ascii?Q?fP+sEIDOGjcIIiSuTc8LhUzNRZSxMHgadgPzbOTvefHvxHNyfxVbXhk+r9zL?=
 =?us-ascii?Q?5vM1JUQBNTAJ2l5L3fTDs3tDuIxhLCGLMawYVQrFpZtZgbw8A61bupj8q7qz?=
 =?us-ascii?Q?wiZrkdx6xHkUROWe/Jq4A7qtX5g/IkyvIiBpIBR2icem4itiQEUQiPAK66IP?=
 =?us-ascii?Q?rFpmY34eDV85L2SO1rdL65+RoJoD1S2bXd3v2bpk7i9UTQ3L2gtaM98Che4v?=
 =?us-ascii?Q?4d4mpUlEDYN6l3fkbUliX7BVrA9SL6G7lIs52K30UCHSkWCVUbTrCXmcJPJ/?=
 =?us-ascii?Q?gTPJY9POCAQALoi7fgP5xiFuj3CxIYgyuGJs36xcF3UkuTM/8tD6Hdke6Vqo?=
 =?us-ascii?Q?eDGsJJWD/izi2V+EWcxkDM58rFMum4+4kLqoWAzuxjWpSWvjVit6/mgK9X8d?=
 =?us-ascii?Q?NQUkNfNXWvMBDEMxYp+/ZPMHMwRDN1sVYIJ8Q5nJZv4LuMAMG3hsJ/YYhKW4?=
 =?us-ascii?Q?V6nHVwd0PsTu9MQZg1wvta5LnyDWAza1I8UhnsXwvv8SmslYyjCCgS6tQ65d?=
 =?us-ascii?Q?MKHjBqWXs8XRCmKBwutjnMTuVY36BA1VZJ4HDLq2ZT+TD9E3IAskSpDm4zlS?=
 =?us-ascii?Q?qfGI5Mbh7O1vqDdc/Jr6gJ9GL0jL8pyN9G7OqSfauwjAUw6gWJjYcAKLw+UJ?=
 =?us-ascii?Q?+JhjVVFJTkpjajuoTA3VLDiWxOK2kHQsAzmqexg5jmjYZx4ekyt6jhHVJRcu?=
 =?us-ascii?Q?NBaEw8x3K2tfjfFdDIKsLtjfZGcOp9uRNtlvH6AgK0ejAn108ocMuR/V1ERW?=
 =?us-ascii?Q?rC35qHlKyVgS3DvHeEOofqZkDlLILdLnnE+8bz/RAv7GYd3j/v2Q0euXF8is?=
 =?us-ascii?Q?Nla360eN6/EA8C7cxFJ+vj/NveW+gkxcHHfRJdZdU6CivYcJvpp0ogDSdlXP?=
 =?us-ascii?Q?RSb7RH82FOgiDpWypvQkK7lYWh1euh39gwtmui9m8eIkZu0MU9jW+7TxCS35?=
 =?us-ascii?Q?8UJvFky2GTdNUVpmLBmAMMHvfC+1YHt4xesPBPq7?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e06877-f0c2-4d70-4cf5-08db23e49ac3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 17:01:36.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsyN4iVNYCQaeYO9Ajzwk9EOOptsBPHEcv266zoHJC0zgkPCLCZE16nlOTOJbOPcMIGIGtRlgH8Ok69R/wG/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 16:06:06 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> On Thu, 9 Mar 2023 at 14:11, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Mar 09, 2023 at 01:46:39PM -0300, Wedson Almeida Filho wrote:  
> > > On Thu, 9 Mar 2023 at 08:24, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:  
> > > > > > > +        // owns a reference. This is satisfied by the call to `get_device` above.
> > > > > > > +        Self { ptr }
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> > > > > > > +    pub fn from_dev(dev: &dyn RawDevice) -> Self {  
> > > > > >
> > > > > > I am a rust newbie, but I don't understand this "RawDevice" here at all.  
> > > > >
> > > > > Different buses will have their own Rust "Device" type, for example,
> > > > > pci::Device, amba::Device, platform::Device that wrap their C
> > > > > counterparts pci_dev, amba_device, platform_device.
> > > > >
> > > > > "RawDevice" is a trait for functionality that is common to all
> > > > > devices. It exposes the "struct device" of each bus/subsystem so that
> > > > > functions that work on any "struct device", for example, `clk_get`,
> > > > > `pr_info`. will automatically work on all subsystems.  
> > > >
> > > > Why is this being called "Raw" then?  Why not just "Device" to follow
> > > > along with the naming scheme that the kernel already uses?  
> > >
> > > Because it gives us access to underlying raw `struct device` pointer,
> > > in Rust raw pointers are those unsafe `*mut T` or `*const T`. I'm not
> > > married to the name though, we should probably look for a better one
> > > if this one is confusing.
> > >
> > > Just "Device" is already taken. It's a ref-counted `struct device` (it
> > > calls get_device/put_device in the right places automatically,
> > > guarantees no dandling pointers); it is meant to be used by code that
> > > needs to hold on to devices when they don't care about the bus. (It in
> > > fact implements `RawDevice`.)  
> >
> > I don't understand, why do you need both of these?  Why can't one just
> > do?  Why would you need one without the other?  I would think that
> > "Device" and "RawDevice" here would be the same thing, that is a way to
> > refer to a "larger" underlying struct device memory chunk in a way that
> > can be passed around without knowing, or caring, what the "real" device
> > type is.  
> 
> `Device` is a struct, it is the Rust abstraction for C's `struct device`.
> 
> Let's use the platform bus as our running example: we have
> `platform::Device` as the Rust abstraction for C's `struct
> platform_device`.
> 
> Let's use `clk_get`as our running example of a function that takes a
> `struct device` as argument.
> 
> If we have a platform device, we can't just call `clk_get` because the
> types don't match. In C, we access the `dev` field of `struct
> platform_device` before we call `clk_get` (i.e., we call
> clk_get(&pdev->dev, ...)), but in Rust we don't want to make the
> fields of `platform::Device` public, especially because they're fields
> of a C struct. So as part of `platform::Device` we'd have to implement
> something like:
> 
> impl platform::Device {
>     fn get_device(&self) -> &Device {
>     ...
>     }
> }
> 
> Then calling `clk_get` would be something like:
> 
> pdev.get_device().clk_get(...)

Just thinking out loud here, would it work if `platform::Device`
implements `Deref<Target = Device>`?

Best,
Gary
