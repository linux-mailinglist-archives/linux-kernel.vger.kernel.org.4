Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031B6B829D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCMUVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCMUU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:20:56 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E9520041;
        Mon, 13 Mar 2023 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az/3qcsvYOvg5in8R5rWx4CKjzOrZt+I+oxL0wKzPdNpmxAz2fZNHAEMk4Mjdx2YM3hNPLb0p02WI7CTzga9O4Psab2y6CXuNIjh44IT0B4QeCtdBYp+qyFibRRdrH+C2pMI4nEH1rX6XzJr/zfcwoQooO8sVEfCUkBgj4+PNFyZNsPa/VER5V8uRBumV0Y1HqpR8LucNe1tyDYqYV9feICfVmcbV5LHIbHlC+RZiz+zrCSk+FBU6ttixpk96XblT/NlCZlXNBcXAWTSL5dquwmyCEFF4F3CGe81kGL5JXLHNvTu+ts5FXxX1hgPOzoVDM9Y6OdTOF/91xRRitRXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJamqtAk1wUARua17TYM7K2CnYDMnLythjljKq8rjRc=;
 b=Qc+OmgxxgYEBCemxKuOwrBKE0K6LL6wxUXbIdAKOOLmohcCVEdHLkEauRwIUMDQNUhrYVbTBTjuhSX9z9lcln2+gmHbAHro2LcS+NWzQPRkApJyMzcbzzCIQIZNFaUMhQ6ElX8YRr4US8y1I0BMCTspsCyQs4q5iSR6/R6FKFnrNgtEK8nb9gZQnu2cVEANWzVcbzbkM5rwnAe1GU7eBwqfkubnjbiEsRetRexsgk5WBFjqaYxA6OVK5URDIDFohzwPaNdox6oAsuyz4MG7vy3sQoXVvqdHrF4JmEgRXlBmesouocxezfGnmeB5MsoXbQhY9zlmAOwz9gFC02J4aMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJamqtAk1wUARua17TYM7K2CnYDMnLythjljKq8rjRc=;
 b=CKoOE7Hfs56CPE3BHGhdvpdIOFB6Dg+clEjMWZu1wypFgKdxJNaBP4WpTcyq+yTxgdFFTyNTLAP7zM8JmHGamAfN5ZgngdmKmqf1WItAL3Yn/Ci/FhYirnHexe7Km4vOshpkaR+iDiGhYhjj1KR2hwgozuPDMzZLqAoUaItOZV2/T1YpQI9+SVbGOOSesQmBWQZW5Nz9nvOw7DMI59UkJTLgk8lhQF8qhYmc8RyyoAT8hMvbUnNhRTCOETxVe8Qy1KIq95sExWRR95oolo0TJuiWYIrYYlZKllWbK3/yiB8iWQ/lYM0svuhGPshNLknIcridQ1TAO43GedgCH9WXVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 20:18:48 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%4]) with
 mapi id 15.20.6178.024; Mon, 13 Mar 2023 20:18:48 +0000
Message-ID: <7af815b6-b12a-b8a3-70d1-64a40ed073a0@suse.com>
Date:   Mon, 13 Mar 2023 21:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313010416.845252-1-kasper@iki.fi>
 <ZA7KIs2jA/acpN9n@kroah.com> <a1ba59be-30aa-08e9-65e7-2c458cc164f9@iki.fi>
 <ZA7Wh2Z/DdKOsOYr@kroah.com> <71fd009b-8378-d5b0-5243-5279b2b880ee@iki.fi>
 <ZA9GK2bPd9VhomgG@kroah.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ZA9GK2bPd9VhomgG@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VI1PR04MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: a81dc387-64be-4f77-dfea-08db2400273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzjtEtUH2KB5Yt+JGX+M8OzmikyVdUu9lHTGVNQDGd087CQdrbWQVqprhcQgkIeXRNc3hxmPgyf7JQhqw5AFcHvs5v9QNlLXtWzc5g85vubo45CuWhPglmvC+F4c6AJcmi2W4KffnaAUcBTQPZxtAcq+hyUHdyavO5vjC5Ekhx69i5Wlq7Nb7UJa2+N11hupcd4uFlSUQMhnabrvrLfJlWRT20K7mida8ThXgZIxmfh1w+Mtiqor17dapAaOdBzCHMwFxZ6kCifaaUR37ltov92ASzg/lcDB/tewRPCX7yif4T60Jd778Y7wYpNynqKayCjgY1ou6To2ZZrFLPwcR2vYTgmy3XCGJR8AAw+d2sVtQrhiO/mwG5hjjcH0zL50bwhNT2YFINgZXUJ5p2xnNxcmyErBtJwcpHdtR9PRNCdzvhqog7ncbP7QBi6x/5IvZufRpeZKYDmBYKYO0XHFS3/l4cUEVJ9BQnwhFNRGxgW2jZusC2QYrQoxZjtLwDpLjmi/UtAs0gyvCUQ/r06gR0Th1+k/QOuWaDJQeDL5hmB98YC5To9yeYMahbVhOP4BjqCyQUyTR8YR5w1beeb/0yij88xEKbA98Q0uNnz5Mfvk/zVm4GVyhJtqpRbobiYk7nArhEfOpoaWKoDkN3co8MEzGgPXU2RDrGXSSPliqxym/SvXXoPxSLuBlnq3OnnMaW/6KsR7FNcMOIxdWMppFAtd8lbgKRSnIMaVg+q6PiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(39850400004)(366004)(451199018)(2616005)(31686004)(186003)(53546011)(6506007)(6512007)(8936002)(6666004)(38100700002)(4744005)(6486002)(5660300002)(66476007)(4326008)(66556008)(2906002)(8676002)(41300700001)(110136005)(36756003)(316002)(478600001)(31696002)(66946007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmF5R3hJV3h4b002UUE0WnNyQ2crN3k3Rm9lTFBCcHNyTGlkdkdMSVFFbDlG?=
 =?utf-8?B?aFJmeWJtMTlOOTNESkdpUXRsUWtIU0ZOSHNMMkxoQWFxNklXWnNndzQ4YmVH?=
 =?utf-8?B?akhWdHMzNHhjL2VaV0xvSVJxWmsyWEFiWVpZTlFXWTB0TjBydllnL0dpZzV6?=
 =?utf-8?B?eGh6UC9aV0FyTnRJYWJobTZkb0tEVURka0VYZlpHb0RKUml0UzE1V2U0eUxI?=
 =?utf-8?B?TU00dGFTeFB4eEpCQUZwdTY4RHVOVEsyaWJ4MXcrZStjWWxiTzBxMGRpL0pw?=
 =?utf-8?B?cHJmM2IvT1lyd3F3VDRKZlUyYktscnZSaEozZFlFakJIM2dqVkc2OVBMNUhQ?=
 =?utf-8?B?Rlp3T0hQbnBwUk9EczhlV2J0TW1QYkdvOFliVlpKOTZmNTY2YnFDbzlueUJF?=
 =?utf-8?B?cHROaEFVdnJ6RWlhc0wxN1FLYmhEUXJYNWJ6dGtFdTY5ODJ2aXo0ZXR1cmhP?=
 =?utf-8?B?ZjM2eElhYzUxcDl4UURLZVFzSjBVREMyMHJ3bml1bkE4NGptdS9WL2ZRYzUy?=
 =?utf-8?B?MFZicG9MTFZwN2dSelNZSzBmWDV5T201NVFjYkh5Q1pGd1J3aFVjZzQ3S3do?=
 =?utf-8?B?MVNiM2JqK0l0LzZESEVhZUpWYmx0TlByUWN2V2JTbjdkUFpjYmF5NzhkQW5h?=
 =?utf-8?B?WnRVNldDTm0vNjMrbXgweFNtRHZqdmpnT0czU3psUXJJaFhlOUR0WitNK2xZ?=
 =?utf-8?B?NXhUS2E4dWRUWkFOckF4anIyc2lXVVVUemdaWGx0QWhQYWNDMkM5LzJiSTZo?=
 =?utf-8?B?Y2Y5UjR0Nk81cW9TTDFKcGthR0xCNWNRbjlDQnVkZENVWE5SVnlMZUVQc1lv?=
 =?utf-8?B?Y2g1Y0NNOWdaK0RocFZyeU54M1ZDdmVjdnAremRrejA3V3NLTUxQSkRNQ0Mx?=
 =?utf-8?B?eGNnWDdsRkxUcFF5Mm1pOGM5bzIvRFhObVJSNG9za0RycUxWbHJvTGFFQWhy?=
 =?utf-8?B?T0lIVHA0MlNnZGpPckNwcUZPRXRwcTJvVUI0NTZqa1ZsWi9aTXNUR3F1WXU2?=
 =?utf-8?B?OXpLZGlCZ2tCTmpmUDV0dk1ZZitaM3B6czNNVGpVV0traUYvOTNKZlRSbmk1?=
 =?utf-8?B?RzMzMFdmNUdEVitFUXFBcFU2alIvclA3dHRSYWM0WWpiQjNzdG9vY3l2dndo?=
 =?utf-8?B?aGxvUEcwUXduTjRGaElORjgzbTJSNU1PaktTem93UEhVWVdQTEl1OGpiN21m?=
 =?utf-8?B?eHYxMzc5cTVoL0hGd005T2ZZRXhXckYwS0RaRnBGTk8wL2VpSlRCVXkrKzF0?=
 =?utf-8?B?OU1IT3ZOSnVsdzFXMWpzMEdrR1NONGtab3VJWjJnTkF1bFJpK3JEajJTUWhp?=
 =?utf-8?B?KzJOZ3ZTNmp2bXRNcjV1dWhkNGE1ZDFTUUJjTTI0RkhjSHZVWGloLzR5NFJt?=
 =?utf-8?B?WlVxb2pKa3VtVUZ2a1JvUFdVNm9XRllnMGZUMDlsTnMzcVNJajRsWWZocFFO?=
 =?utf-8?B?UWF5UnNGOGdsWjNmS2ZhMFRDNDRGYm41SUJNMTh4UjFxMXVEMGFqbURJQXBz?=
 =?utf-8?B?aWdaYzVIQkI0UFNVOGxHY0FWaXl3TExoaStMVlFWUjNwUkZBb3p3aDFsY0hQ?=
 =?utf-8?B?cVJVV3hEeFlTRkREcUZmZ3d3UWZDN2M1dkt6cXNmZFloWnkwZ3FCdS85T0dJ?=
 =?utf-8?B?blVRa2VaVmJDVk0vV3FkYnFKeWkrU3N1REhtelpCSVkrSnF5aFFOajc0aGVY?=
 =?utf-8?B?Wk5RUkNMYnc0VzR5YmxyVEVMVUQrd08xVmRvYXhEUEY2OUt1SzdMUEhYUmxD?=
 =?utf-8?B?aGh1Zk0yLzhWaGNGSmF2K0gvcHJNZFpQZVJYWjdHMGx6eEdmZyt5UVUvbm5K?=
 =?utf-8?B?eko3bW5zZ0hhN2NKNXlNV3hmWXMwbDBHTnBBbDdYSGFtbk4rS0F2UE13L3Jt?=
 =?utf-8?B?aGRCaXQrUnVEMGdLUEhRSGduNnJOQzI3azFxcWU1WWl6M2h1dTdadDI2U2lQ?=
 =?utf-8?B?eE84OHVtWnIrdzkrNThwUzlJcTRGenJUWXdmdXp1YlgyMTlRTEs5MzladlZS?=
 =?utf-8?B?WWpwTFVwSjJ2ZVlrcFlXRjZZeDl3YStQRmZRSXp0VnEyMm5GeGQrdjVKdjBM?=
 =?utf-8?B?R2ErcEZLOCtxZFliSmFaN2hXUVNjNkhscHhnWVJRQzgzcGtCMys1eHUvNDBm?=
 =?utf-8?B?UGEvaEZHdXQ2UG93YlVaTnhYQjB3bjNyVzFra2ZxdWF1Y1RTMW1TYjdrb1NV?=
 =?utf-8?Q?WkZCGFDlFtjR7x5SYiYGDSoZw9qmXMZ2f8jkGWzT86xC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81dc387-64be-4f77-dfea-08db2400273e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 20:18:48.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HObSE5ivHvwf1IkjbMUN9LC+Uod5pltdZ28aP0Sgm1OxdR6trcQBT3HSSuBL3z74E/KpfV4T7UsCfvydt3c8sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.23 16:50, Greg Kroah-Hartman wrote:
> On Mon, Mar 13, 2023 at 05:07:59PM +0200, Jarkko Sonninen wrote:

>> Using ENOTTY breaks all other tty ioctls.
> 
> What other tty ioctls?
> 
> confused,
> 

This is one of those handlers which simulate OO inheritance in C.
You can implement any IOCTL in the driver. If you do not, you
give back -ENOICTLCOMMAND. Any other error means that you did
implement it and an error occured in the method.

	HTH
		Oliver

