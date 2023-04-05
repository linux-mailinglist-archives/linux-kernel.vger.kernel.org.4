Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB26D8A37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjDEWBf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDEWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:01:30 -0400
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA9C7692;
        Wed,  5 Apr 2023 15:01:28 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 335M1KqW016554; Thu, 6 Apr 2023 07:01:20 +0900
X-Iguazu-Qid: 2wHHmhMsGZCr9m8ktM
X-Iguazu-QSIG: v=2; s=0; t=1680732080; q=2wHHmhMsGZCr9m8ktM; m=D+oJM7Ity5a/bmmgYqLwb3x3gjKpQvTPm5vlixlaEAA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1112) id 335M1Iit029747
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 6 Apr 2023 07:01:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgXMNYRgWxLk1PgTP03IEC4MNw6B0WLkNhF0AHbYAQNP0zyixqOCVZp1lOfTSUxIgOt2BnIEEpxo3qFprDYp+0Rj9KPWgpZS5bVtYJrdWaqZdZOaEPT2Ez9P3a1cjIoJDiZPpIibNCzk8G0A0tyt/2JxUCfWKjNzKkc6GCOoegeaWrBTxQJ/r26g5+eZdIF9MvMfrxXMEyrVvF+P9+wzY/EL+czjLHhf3RgYcby8RQ88OkH0/vR4m7nx0th4m2RAHCZEXn0BShgobIepyKLlT4OSgJ3xZLuqb6a7a/1+KyqG0Qa+dBLJj6PhcdOS4i8wHX2TgQpFo0vJej7+2l4jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66/JNg70qwlyJbCmkKUak74pYdAj+7u5PI33seXBdKM=;
 b=Yi3xTdDKZCGt0UFCW5u66OpllVXrG6O04nuo7Tpa9t3hleNuCO+G/8kuBLsF0EIH0V3pUacohXDQkkVZ9KXu4m1iZhCEtk8XQBPdSa3SOnTatWapH1EHQymbjqd2HTdySP5/BVoYqgSEevzOz6RVMoS1fnxaIpCOkRkwT6cmooL8HeIcA7e1XsuAfM+fUQeF90lBKT4Ifee5OGFBSLX+b2dJLPkLGAQQ/40TmAUbeUiEyikGKTOKdeMnLSzGnhxuNt21fuajIySHwcDes6ya/6s+MhyKJYC4dWUTs3QWpxcC/aVfxDwSdhslDjbIDs4YfdOK2R/k5V9KGWtKaSABUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci-plat: Use dev_is_pci() helper
Thread-Topic: [PATCH] usb: host: xhci-plat: Use dev_is_pci() helper
Thread-Index: AQHZZ4yszw2Uu6nch0evsEAfagPfg68cT50AgAD1WeA=
Date:   Wed, 5 Apr 2023 22:01:16 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94208A9EDA57A18757715DCE92909@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230405070141.2028455-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <2023040503-catatonic-gazing-9830@gregkh>
In-Reply-To: <2023040503-catatonic-gazing-9830@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB8782:EE_
x-ms-office365-filtering-correlation-id: 6d7f755c-319c-4169-4d90-08db36214785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQmDXcEEGIG2oPSEHYptmvLwS8vbE1xgHC269hvg2aiOx+CGRB5cHIPEc9D36aJI1t0Bry5dGA8ZXvr6Hj0pAHsCdx6jKYraXdEqz5pHCrAW2WEK+Fp9mkRrTPRpoyHTPRjJpTiylUrAfZcjJtNyfJhAsr644UrxUYdzouTbOKyix3d4jxps+5d3wxiXTC5BmaS6MAC+N/hyQpcVTtbq88HMW5agCL6akTqdqkOFRBFwTN7h8ezPtDqt1sPRHY4JH6JsQr9TSRAmmUg5y47lgc78ccin4i7drpbskjprGAkuzNxu4KKbyOefEbJEVtjXT+GWZCJIgWkQWraab/yUwT3mckWT+1Jfyl3MggVmXXpitAYTJnSHIdWX4iWh1+NqXwEOWuc2ZZvbmAVXtBTt+qmqlwcpdyfF41RI/YenmtzCmK8dwzrpamY2OjJcgrBaThuyVRPud6o7u0nPwWGCcBwGZ5NDSzTou5pggmWCzouy450+mmRSshkFI6CvvTtGhyi7addtUjnzG4ny0zmvN2zVZm90QVIN1EOCNndl7YT/JDL+etj5L5b/1wFOkYNp9m7/GX4LFaMcKE9XQ+cZK3ORk94uCMByLSuhur+nfarFCgKcCDatVhZXVj1mz4dQcrFF8fIq2Dr43QmMsb+uSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(71200400001)(7696005)(55016003)(83380400001)(38100700002)(86362001)(33656002)(38070700005)(53546011)(26005)(6506007)(9686003)(122000001)(186003)(66946007)(2906002)(54906003)(5660300002)(8936002)(41300700001)(52536014)(316002)(76116006)(64756008)(66556008)(8676002)(6916009)(66446008)(66476007)(4326008)(478600001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TGF5UHlJd01ZU2NTcVVBNHRxdjhjWHFJY3JFN3RpSndJUUxIRVdoekNS?=
 =?iso-2022-jp?B?b2NuNGxLSWttYUZFd0pRVjVpa3E3SmhBNzlYYzBDU3puY2ZGVkJSSGh1?=
 =?iso-2022-jp?B?M3oxR1pJRVlrWE8wQ21OdklpR0lkZlpoQ09zb0xWbVliNEVRRlZ1UzVD?=
 =?iso-2022-jp?B?YVk3ZnMySlBXc2VPYmo4ZDZXNEl0emxSVEdnU2tJbTNwcjkwVmQwMzZK?=
 =?iso-2022-jp?B?STZSc3BwK3VndWVYeEtVM3hlRFJPM0pacHZXdjFBbE1sQWlmd0hWZ0t1?=
 =?iso-2022-jp?B?bzBHRkJnWUd1TFR4Z1FMK1JZeDdkazRWalhBZ3N6UE8vRm04U0ozZ2ZE?=
 =?iso-2022-jp?B?YXFQWnBKZ1lXSE9xK2o2elo5dWt1d1pMRUt0NWNxVzN6djJicXNIOVB4?=
 =?iso-2022-jp?B?Y2k4Z1c4Q1VKQ1l0T0JsbGVBa2FTUWN6R3lNVGZ0bkhyOFZEanJjOVJC?=
 =?iso-2022-jp?B?U2pvdFJGenFJYU5HL1kySVFuTjdaQlVNRllZVEpZc3BQZ2tueWkxWk40?=
 =?iso-2022-jp?B?eDdFVHBrTUU1cVM1eExFYWg4Q1dlL3VXTk1HSXNHbEYwOU9BNjhUamt4?=
 =?iso-2022-jp?B?YjZxZWlCMC9pZlBnRFFYTWdBN2wzY001QWVYVFBjdnZtSFNJakZ1d3hD?=
 =?iso-2022-jp?B?bTN1eEdmSUkzemhHbnFLTUxjRnZHTk9PNDRKTHZwM3hNK2J4azZVLzEw?=
 =?iso-2022-jp?B?YWJHalRERlorQlRIcDNabU5aYU5rajJ6bCtsRlRXUm9zVGtHaUpWTTFn?=
 =?iso-2022-jp?B?bW9CSUJSZDhta3p1NFR0V1BKcU16ek8vUlA4dkRuVHRDeC92T2JxbDZM?=
 =?iso-2022-jp?B?ckpMRGdSaHM5Wm51YTJaZmkvOTh4RmtVMkhKY3VpOU1jZlMzZXBka3Zq?=
 =?iso-2022-jp?B?UTR6RHIzWGxGQ2tqWVV5YWhscnpFZ1lGWkFwb2l3anU4ODc4NGp5a0Fp?=
 =?iso-2022-jp?B?c3hFSm9kS1pBTStnTUljZlFtVGphc0YvWXJ6cTlhMHdNM2wvYXU5TGlz?=
 =?iso-2022-jp?B?blpWYUtvME5tUWxEbkV3ZnBtQUcrcitBSitKeGIwR0RmajlINkpEK2Iz?=
 =?iso-2022-jp?B?MjZBZXpFaFZZWndGeFFOVnJtL0JDeUZwNHZoTHBYMmZseUVoNms0NmJN?=
 =?iso-2022-jp?B?ZHNlaEhRYXl4bG8xekh5a0dSY1JiK2FzWTFPa08zdWN5Y2x2MkpsNnhB?=
 =?iso-2022-jp?B?UHZONlZnbkh0SjluMnJEeS9ZdUtadUoyaytDeDZqVVozNitHUmQxU29W?=
 =?iso-2022-jp?B?cGNVSWJQbXJ1NHhJbUgrR2REYkorcnVjNlpFVTBRWWFHakJaVDlRU1o1?=
 =?iso-2022-jp?B?MVJreFdBMlk2QzdTZW5UZ1oxelBNcldiNEQ2U2w2d2VlaU9rOFozYk15?=
 =?iso-2022-jp?B?bm41dS90UUVzQ1NhWTB2NlFkVVJVWVZVRHozTGNUd2p1dWpOQjNMcWdK?=
 =?iso-2022-jp?B?bkpuajRqc1RIWW03VlA5S3dXUmdCY1g2WFRySmlKS3ZjUkpyMDB2b3lr?=
 =?iso-2022-jp?B?QnZWb2J5cTkvZ2VCMDdWcGEyMGVmRWNjNjBlYk1PckZhM0hhTGlua05X?=
 =?iso-2022-jp?B?VkV4NW5MVXR4MklLalg4RzZkK3NCcndWdGdhV2VvUGtTZUprZXg0STBY?=
 =?iso-2022-jp?B?M1ppUndUYldtTDR5NGtHOVB4OU9uMEpmQ08rOHlRVkJJNi9QdkFBUGIv?=
 =?iso-2022-jp?B?NXRaYVp4UmJEMitWdVNQbU1IOUR0aXE5NkZrYmQ1RksySGlVRno5Y3Fu?=
 =?iso-2022-jp?B?alZ2eTJYallMTWZXTFQ1ejBybDYveS90a0RVbWUzS2pNbUtHdSt6UURs?=
 =?iso-2022-jp?B?WUg5dk1xYysyTXNwL3NlNGRyVmt6TEdFTHpTMzV3ZTRWc095RHVwcmRv?=
 =?iso-2022-jp?B?L01zbWJ6enUxVWZSUEhUYnhBQS9zQm9RY1g0cXl1WmkrTEViS0tMYkpG?=
 =?iso-2022-jp?B?Wm5zUGNONFE5LzFBeWFURS9NVmdzMTNZZ0xvZVYrTWFZMjdsa0tYQVpU?=
 =?iso-2022-jp?B?UzdDdVlVUzIwRnJkUStRV2NRK05ZQlJuVHJLT2lBNEwwNkU5dis1MUgv?=
 =?iso-2022-jp?B?Z0V0OHAybGZwQ0g0Tzc0ZUkrdDA5dTRycFN3OFV2VFQ0YUY4bVhGZlIw?=
 =?iso-2022-jp?B?OVVpZ2dVcjFkVmdERE9IaGJSU28yUWRBRXlHWjE3czRUTkFBQ3Y3eE1H?=
 =?iso-2022-jp?B?TVk4em9tcUZHYkhnTmZNQ2FGNWpwMW41OVFFc2NBV3IzSnhVZDV6MnV0?=
 =?iso-2022-jp?B?aFJtWTJ1Q0xpeXVqSVg4RFBBUjNLeEtXWFRtTW5XOUpyOGZrQXVKejV6?=
 =?iso-2022-jp?B?c3JHZzdxVVNjOXBUR0EyWGEyZHV5dmorUWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7f755c-319c-4169-4d90-08db36214785
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 22:01:16.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLNzOkaGiaIwjr8B+daUh7e8a1Pj1MOp8rExB3CoqCFii4QxKF5S8E19P7vIo9ZIm5iJGb3f6e4t0stJKUdk2pgfmczBCBTiSKv5bJmmGU3+juhtQDmxe0aAQfXgHdKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8782
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, April 5, 2023 4:22 PM
> To: iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: mathias.nyman@intel.com; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] usb: host: xhci-plat: Use dev_is_pci() helper
> 
> On Wed, Apr 05, 2023 at 04:01:41PM +0900, Nobuhiro Iwamatsu wrote:
> > Use common dev_is_pci() helper for checking PCI devices.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/usb/host/xhci-plat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c
> > b/drivers/usb/host/xhci-plat.c index b9f9625467d61e..2c95189424fa6e
> > 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -363,7 +363,7 @@ static int xhci_generic_plat_probe(struct
> platform_device *pdev)
> >  			is_acpi_device_node(sysdev->fwnode))
> >  			break;
> >  #ifdef CONFIG_PCI
> > -		else if (sysdev->bus == &pci_bus_type)
> > +		else if (dev_is_pci(sysdev))
> 
> With that change, you can also get rid of the #ifdef lines too, right?

Yes, that's right. I will send v2 patch with it.

Best regards,
  Nobuhiro

