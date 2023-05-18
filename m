Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89F70794D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEREss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEREsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:48:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F46211D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQuia2JS/hRnlSvF6NihR4mmU7U35qvb6xZRixE0//aGdNnLCA/5YVgHe2rV50mFyA+ptfQSVF+jdX1YwImdEXbSK7AldtvOpu5bXq/HZ8++bczuTVSeSdtFzymXu5O1n5WjsNNzhzAKwyqSdzm0pV0L8I9vtU0rksnWLLmQNEGqkMhQnDVUUjv/WqTg0r6LgjCRBfOX/BqtxtcWjw4D3GQZJwPHpELKhMno7hISRwpgKw0lrEEOhgeCkYQcVqHeMSqmeCvTFSjlg2E3cmrrdhHGfoYARhWqEyQ+zDlXTOi4j6BnOU9ErCau/tdTmiBeRcuMZv1hEMiP7ZdMw9lqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbboEE3lioXc1vgrLNPpjyE8W1FjeNkSEkOaMOhDF/E=;
 b=dMEN1tkTLoGMiZM1SZsH9bco8j3zvI3vbmvX9LTCdGcRyRlkF5gQFn1bejwk5IZiJ/TcjRUqLUhXZaR8/OnNGrNN6e0IO1H5fT9MznPfoV0Kq/xuOcN0bHhm1Zk6ZSFsvWQ94Dpba7hdUqXxZNknrzccz/gheVee5pwUj88QKctW5HkRMtdHpX+FtKwLnqIg+Je3nBw92Pd3+og9uLBlMG8ZXHjSeRRpCtvLZFPZu2TSViDeC0dwriEaXYjjM3otWYoOCsyfEaU4dx5/gFU612BTo+q9RqU5JsqUa0bqzOfJfQkA49bsZTLnxNWQ8PsMTjx+eGGmz4jKCQZSZum1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbboEE3lioXc1vgrLNPpjyE8W1FjeNkSEkOaMOhDF/E=;
 b=LyM9rfS0hF9NW4leMdQG+rjgg8uSk+kmaNBp49OnAyrvmqcrbZKMqazTTtdI6v65cFOTNgKIoafYcHoCk8KV0n9FlI0dSG4RrEa7shG/Rn+C/lwigFGc2ubRxL+toxRErdScfD1EdHylCUe+TRy0JnOQ/J3CbH8VH/NcPWFJb0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OS3P286MB3253.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:212::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18; Thu, 18 May 2023 04:48:42 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::91e1:d460:5907:34d6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::91e1:d460:5907:34d6%7]) with mapi id 15.20.6411.018; Thu, 18 May 2023
 04:48:42 +0000
Date:   Thu, 18 May 2023 12:48:34 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>,
        Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Message-ID: <ZGWuIuNzUweltdqQ@Sun>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
 <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
 <20200428135443.GA1437053@kroah.com>
 <eb405ab3782844e379629a655a3dcaf38dd2552d.camel@iis-extern.fraunhofer.de>
 <20200429094141.GB2080576@kroah.com>
 <03b6755c07fb19420a7fb21b434b137aaa238893.camel@iis-extern.fraunhofer.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b6755c07fb19420a7fb21b434b137aaa238893.camel@iis-extern.fraunhofer.de>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|OS3P286MB3253:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e2aea8-4687-4b0f-337d-08db575b274f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMCks1JVRaX249iGQ6vHpUuFL8IBUliaBUOt745YlUe7G0pQduUzoYIJiPrTnue+3aKvu+BdY8ztdIp/LeQ5p/8ohX7eSyoocKijyQGIpe7U3dEfGG6nYxdoVzsny3hWvvSG0Oqwtvkyilp8QFXcap78RC0nvAolR2Q5frwMLhGHC1vnC8kXoxRcvEVCyPQs5b4sVsrws4X+0zUPRnEAT6A4SSjmVbHpT7qAn5mi1y5yXz5FSk0drKHnKlkVMyacZlvc45inST6/+fwW7YnXfRFVKBJ6YD2Xo8hbNsYulwrGBeZ+Nf1nf/NF3BfnK/NCeDvDE4nn9ureeEsMglHF+zz3uZzac02Z3P5++zLLcT3Hml5nVGQq/x53oeKmBUZcGS3M1iWOxACXSckQvbZYvXAvFj0AKG2T6COURw7ozy4Fi2X9eXg3rN+uHd821vjJ281W/LK3UTQQBvhNCbfwpxpclyJumUpsMNYyyPNfeV1Sc3hycLri4MQ314b0Iv/3pIEGVZd/SJmFWpBi14kvPj5wWJS1Ovy+LgWwxgn+BA+ccR/jkXVJqEyn4Ruh1f9+nXrwC3/wnInVBeLfbuSxoEChVtVqz9P8GZThmoalV34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(376002)(39830400003)(366004)(396003)(451199021)(6666004)(6486002)(6512007)(6506007)(9686003)(186003)(83380400001)(86362001)(38100700002)(41320700001)(33716001)(4326008)(316002)(786003)(5660300002)(8676002)(8936002)(66476007)(66556008)(66946007)(110136005)(2906002)(478600001)(41300700001)(54906003)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+25W25t5MQZU8nmSM4oubt93FeXQEkgVBj1JATBsRpC/kJC7aNWr6oaR/0j?=
 =?us-ascii?Q?r3rrz4TUCeitfNER79s18pVqEcF8bHeKlp33FURgN36j8/D59kIijpHRoYCG?=
 =?us-ascii?Q?C2ROQT9Aaq2foOcMROxEEGOcs7iVsa740rhjIt2AX+GzPJQtkmMglzplYsVU?=
 =?us-ascii?Q?pKmk8unVzyVWZtaMpSMaARtuFHFEzNOsExaUT29HlrE14QqMEx1qZfmn9UGB?=
 =?us-ascii?Q?d8yYeZMDA7uLZ7mYR7KvWo/RmA7SR56O3IUE3F5XLkn3swC+A31q9NAtf6Wh?=
 =?us-ascii?Q?ZssrEYVnkP8kw97vkULNeiYZm4Ta0Sax7kzhe57v8dRKost0/e78Issyo6KL?=
 =?us-ascii?Q?DiOsyya4jN1TAPSaILh4ets4ByuA5tBgcmBzwhvGkizTKOaguazFXlxgaveZ?=
 =?us-ascii?Q?p/s1CMSjHRooKovOk8w4j9VBEzyQLZ9ID6/11XxmCvNXOHf3MKDkR7HKPfk2?=
 =?us-ascii?Q?Eov9wTo/1Ex9WaXVSDef0ITCJNGqHhGte3HaLm5E4bzfl7XHz4s+dfxMCxYV?=
 =?us-ascii?Q?L43ZHRBoni/mf95rAKyJBftsapd44mXnYp3PfmLsp61sjH8fj5dxMrKlFI8n?=
 =?us-ascii?Q?ofolYNMIeEmL+UQscrORrXinztbTevJG0c0lRwWO0HticXLz2xvFuNo8ffv8?=
 =?us-ascii?Q?lQBGU4H/OrDlR/HrXSDnahfgWDp21lOirFap4TzaYQczn9zWOCk7h9wKje6z?=
 =?us-ascii?Q?iKN6IlcDoUqUsGwRZmDxMQZo0UP1Wi7GkGRbPBFassA2casWcRtxg1m2yq2s?=
 =?us-ascii?Q?7BicwaoWmhyLClacABSCN+TgbgohuZ7bxFxY66uUjPKOGScVNTLZuDo+c8Qb?=
 =?us-ascii?Q?YOpUFdMVYG681T20/y+wRH6eWSTUuuq0E8cDmTwuQO2ybth7OOGeNEkj1fy0?=
 =?us-ascii?Q?hww1KaGEsCEz39YTXZgb5HlPBN7OUEaIWsVnXdu9JFR2Y+g6b3H1sFsfN1uS?=
 =?us-ascii?Q?bjVuxpbxW6ibKu0KiiMVXj88aQs7QUzxaKUjgd68zUK2KVDmEfcxjimJy24I?=
 =?us-ascii?Q?uxYG4ed9rlsaGRGLkT+OGa8NUPHtnm0LKDvECmV7nUnc+aXoSbo4Rt7b17TZ?=
 =?us-ascii?Q?JFpx04QZGUOETeGnpeUyyKk3RiKQIXlIMaEbzVLqQ30NF4gfeJSrsJXKFErA?=
 =?us-ascii?Q?tk6zYNdFIuphmpBbRsPWXjHBg0tc3Vrky+8xRSzhGuC1T6xOLf4UrHH4OWLm?=
 =?us-ascii?Q?YjV34DqZkcm/FXCGDLvj6RxD5Nke8mKizo+H9Z5b0G6X0tWQ77PdSmZGxGZF?=
 =?us-ascii?Q?2Dg7dJYbX/k2qC51vTUmoN13DoNSvdkV7cbAESpegr/WG/ORKLu7YIKgAZqw?=
 =?us-ascii?Q?9Wjg1c3yzmlZ5FPe0g/hlhrVCyqHxzO4CqraYQ9rEW9Wjv/WTB3NRZxHpt9L?=
 =?us-ascii?Q?6ckCp4uh6nboBEG7TqB7vdpTw9RX5zFHIfp0IBxIs4cEAyeoF7yh8kMfG2H0?=
 =?us-ascii?Q?/uSL/scR3kxUKabM9/DNXrA8tUjf1lw4gm/5iVhdWoIHe+YJ5SjFSmbpARZk?=
 =?us-ascii?Q?6POIW+eFMuNjTXSHFWkXeJMmD9wjsVzcV04kIvmz3rvY7KexiHmLxsy5jcWU?=
 =?us-ascii?Q?lLqEQWh5WWeA9z8VuHftr+iaufRdNf/sBhHZEjQL?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e2aea8-4687-4b0f-337d-08db575b274f
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 04:48:42.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVFETLFMjHSAKm6949dxDzd2A3EDo1kaRFYhAG6U5Dtq+oKFUUZsZgUE1GFDfjRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 01:53:02PM +0000, Stahl, Manuel wrote:
> On Mi, 2020-04-29 at 11:41 +0200, gregkh@linuxfoundation.org wrote:
> > On Wed, Apr 29, 2020 at 07:51:01AM +0000, Stahl, Manuel wrote:
> > > On Di, 2020-04-28 at 15:54 +0200, gregkh @ linuxfoundation . org wrote:
> > > > On Thu, Apr 16, 2020 at 06:38:30PM +0200, Manuel Stahl wrote:
> > > > > 
> > > > > + *
> > > > > + * Since the driver does not declare any device ids, you must allocate
> > > > > + * id and bind the device to the driver yourself.  For example:
> > > > > + *
> > > > > + * # echo "8086 10f5" > /sys/bus/pci/drivers/uio_pci_dmem_genirq/new_id
> > > > > + * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/e1000e/unbind
> > > > > + * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/uio_pci_dmem_genirq/bind
> > > > > + * # ls -l /sys/bus/pci/devices/0000:00:19.0/driver
> > > > > + * .../0000:00:19.0/driver -> ../../../bus/pci/drivers/uio_pci_dmem_genirq
> > > > > + *
> > > > > + * Or use a modprobe alias:
> > > > > + * # alias pci:v000010EEd00001000sv*sd*sc*i* uio_pci_dmem_genirq
> > > > > + *
> > > > > + * Driver won't bind to devices which do not support the Interrupt Disable Bit
> > > > > + * in the command register. All devices compliant to PCI 2.3 (circa 2002) and
> > > > > + * all compliant PCI Express devices should support this bit.
> > > > > + *
> > > > > + * The DMA mask bits and sizes of dynamic regions are derived from module
> > > > > + * parameters.
> > > > > + *
> > > > > + * The format for specifying dynamic region sizes in module parameters
> > > > > + * is as follows:
> > > > > + *
> > > > > + * uio_pci_dmem_genirq.dmem_sizes := <uio_dmem_sizes_def>[;<uio_dmem_sizes_def>]
> > > > > + * <uio_dmem_sizes_def>           := <pci_id>:<size>[,<size>]
> > > > > + * <pci_id>                       := <vendor>:<device>
> > > > > + * <size>                         := standard linux memsize
> > > > > + *
> > > > > + * Examples:
> > > > > + *
> > > > > + * 1) UIO dmem device with 3 dynamic regions:
> > > > > + * uio_pci_dmem_genirq.dmem_sizes=8086:10f5:4K,16K,4M
> > > > > + *
> > > > > + * 2) Two UIO dmem devices with different number of dynamic regions:
> > > > > + * uio_pci_dmem_genirq.dmem_sizes=8086:10f5:4K,16K,4M;1234:0001:8K
> > > > 
> > > > Module parameters are horrid, are you sure there is no other way?
> > > 
> > > You're right, seemed to be the simplest solution back when we started developing this driver. I will try to change it to sysfs, so that one can add regions while the module is already loaded.
> > 
> > /me hands you some \n characters...
> > 
> > Anyway, configfs is for configuring stuff, don't make a sysfs file that
> > you have to somehow "parse" please.
> 
> Looking back at this driver after some years I realized again the reason
> for using kernel parameters:
> 
> The current UIO API needs the information about available memory maps when
> registering a new UIO device with __uio_register_device(), which obviously
> needs to be called during probe() in uio_pci_dmem_genirq. Otherwise there
> is no device file in /dev to open for user space applications.
> 
> After that there is no function to update the uio_map info. So we can either
> keep the module parameters and allocate the DMA memory during probe() or
> allocate the DMA memory during mmap() and
>   a) replicate parts of uio_dev_add_attributes() in this driver to update sysfs
>   b) add a function in uio.c to allow updates to the uio_map
> 
> Which way would you go?
> 
> Best regards,
> Manuel Stahl

I have similar need for our FPGA project where DMA to
userspace is wanted, how could this be moved forward?

Cc'ed my collaborator here.

It seems that there is not enough maintainance bandwidth for the UIO driver.
I'm willing to be a reviewer, and I assume after handling some of the
patches I can manage to do it. I wonder what else should be done.
