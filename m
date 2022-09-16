Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63375BAC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiIPLJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiIPLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:09:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60127.outbound.protection.outlook.com [40.107.6.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202802188
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz68FNU3uP1nWSes/ZSJp/Fej53uc90gxFNfRlAoI8X1i2/pey05kZwddKOj2FFxGx/pjB6aK3EIzlquW6NE2ItBDDvDeV7hBQjXzHEZNJoofmevzSuZfzLoKJUqORhlXFGKH/Ame+YJ0ZtsCPI8NRT6UKLsVBDoonskJESfCzlAs/8Q+mkgfgbyFXRkEMY0qWOPRM5D+KLFmjm8v6LaXpsm8ELWWLwlR3yEMFhowD7yz8CvxccFhQTa5/eZMNzpQRA295g09GM8Dw+TEBW4czCEuM8xaSaSQMTEkb95V5Cers7i1vEat5r0B9ivSOU8GJUByJts4U4bzNLEOxNBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCWMSmcN2TylT+ST5RhLYJSqQsrgD1vdiU7nmdjJ69M=;
 b=M+Nr1GyBJIRAU7Yh9HomYBFCIWGQkKxFlPxAZv2JeFbwhbE33216IJJmmgecjJJaTSqb3BV0b8ht6p1HZHJMPp5B7nx4MZPuUPHyn9PpLqObjjQmRkTM54wWlmZLv0LdaYIOLHCpSLx9DsBK1EbhWBrJYuAKe+zlyOt8WMokSFSlDlnk1N7gbNGwwf+UrE3u+kOyNZrsr0WuNQuLOiNvgUoSXCe9sQa7neJin5nlP0wxasTxoTJQrXoaaYiKFPcujPiHYTvbF/RcLwu45zSJ1o8OYJGqneJ7sv25tnJ2a5a+KbMr10uDgj1ZLrMPyzJwXPA5VkYeRu7gAd7Xq7TfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCWMSmcN2TylT+ST5RhLYJSqQsrgD1vdiU7nmdjJ69M=;
 b=LYHZK5HvzhngS6zkUJDpl4taMHpGgyJLdoTiE86M9Tv+oMSekaMFYSFtJIEaO50yjA7qPCqMXC8aE6C2nDuD6OUiPEP4bgw3EMG7fCupoiaT3gQ2d1svwpAwrtYzR2mpBXMlsYNRBq4y8Qpd2tVJFzRQauf+CvyfuwRIpF5dXT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by DBBPR07MB7625.eurprd07.prod.outlook.com (2603:10a6:10:1e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12; Fri, 16 Sep
 2022 11:03:10 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::5a5c:9cd4:c674:a6e8]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::5a5c:9cd4:c674:a6e8%7]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 11:03:09 +0000
Message-ID: <5a53ee90-d49d-afb6-050b-4649631f8910@nokia.com>
Date:   Fri, 16 Sep 2022 13:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kasan-dev@googlegroups.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220827213009.44316-1-alexander.sverdlin@nokia.com>
 <CACRpkdYgZK1oaceme6-EEuV3F=m1L5B3Y8t6z7Yxrx842dgrFw@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <CACRpkdYgZK1oaceme6-EEuV3F=m1L5B3Y8t6z7Yxrx842dgrFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::9) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8658:EE_|DBBPR07MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: eed1528a-b2c4-4813-bd8d-08da97d30a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yu02b4lpeSp+314DbQ6yeNxPvEoS7boYqQEKYFkpT/OtsjeqzBRwc6ZpppUspujQwiAWwQY/I0HHpNaOVvcgwx9MD/9pjowQB2Ia6jCIe73Ffiy8Pqqzrzdwt7GQnaEssM1MRfQHGMpLCA4cd838rEq2fdAbKyXCya62yw6NpdgGfzM0WsNdM2f7R6aQ5V8gP0I/ybhEHR6xHC97DE1F7WioTrCVqSVw8aSKjfxKZ/VeVlURNSl+wK8JP3EulL5kKnd130GtK67sjRi3JxmHk6ZljCegfPSn6THV4bQhWXrtzd6OkEsP/dvI7TPgUCJxJqy48GM7p5JeGq3orpKnDGGQXNMFPag1n7SjV67sjBITy6PhANsJRAQDIUIdwkdl9SgY8O+Xu/zA+fMRDNQRWiWWRcBP/TZ8ch7c6OI04RmvZ3HEi1EK2IRWwD3QWRwxk26pdc7Tk5DRhBu/DQ3HJzuXYRcmLQtb3Sfkc8FWmJ7eHrgfo80wGpkVlTu/foYWBcEUGgK53DuiibZwFlpEeuCJB/6PGId/Q+T8+PwfMdVWNehAAgFfzk+X8C5+VHJNzUbe5Y4dBVmneSjCy9shDOyDeqCoaZTe8Cr6mnE2KBG7IvYEWjhKCnp2mPcCjEJ7u+NMzY8fwIgKb19CTyFeLCIFl4peazH1ewBRH5l1s4IZC5yekIQwLblCmXRUeZopCYOulxqWP/ubY0TM/Rc5dcRAT2j2k1k7s82glrHw2PzNF/fiuDI4unrStwUOpAODuHH4MmGKDfoQtW0rQDY0U41w8CthUoeMi+S486VZ0QNyOkRbWm3So3VOiQvOVWgvs5jcM5WSpk5rZF69GUTDlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(44832011)(41300700001)(7416002)(66556008)(4326008)(6512007)(4744005)(66476007)(36756003)(82960400001)(8936002)(54906003)(86362001)(6916009)(2906002)(6486002)(53546011)(6666004)(31696002)(26005)(38100700002)(966005)(5660300002)(31686004)(6506007)(186003)(316002)(2616005)(8676002)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNnWnRUWVNnZTVIdGlWb1pkYVcySU02VlhUMk5FRnNsdC83bmNXb0hVcEww?=
 =?utf-8?B?dGNQQUY2RDJqcURNaHlkcVAxTzhSUnRtTzlOSUtPNHpIL0lOUFZUMkhYb2Iv?=
 =?utf-8?B?cUVBNXcrWGN3bTlYRmhUNHVmVmFJMWJyZVI2dFVLOXkwNGpqd2xYS3RZWXFp?=
 =?utf-8?B?UWJ3bGdMMVVsOG8wTTdKQy9yYzZHQm53MDFuc2tDbllHdWozTFJOK0R5NG41?=
 =?utf-8?B?KzNEcTdueUVLOFRoNzJqdFVraWkyT2xqVFFraUZlajFsZTc3S1o5dzUvMmVL?=
 =?utf-8?B?RENVdkNSUkUwZmhSa2NNVVJiN0E0UnVsV1phRkw3eVp5RXAzSERYYlBWLzVa?=
 =?utf-8?B?dDNEZ1BFWDBId3YxSlJTS2x6WWQzd1hQQk5OdEJBRjZQeEdhVklINjdneVpQ?=
 =?utf-8?B?ajFDRkpuTnROaGdtMW9nUk0yK1k4WC9vK0ZkTVV2ZTJ3a3RyMTlMeGo3ZHJ3?=
 =?utf-8?B?d1kzNkI2QjdBbC9KcFVvS0d5OW5OUndGQkFCRWRrbEJDNExQY3J5Z1Q4ZGZS?=
 =?utf-8?B?MW03ZGJ2YnB6dFAzaWlqU0ErYkRmTDlaSWtmWDNkMzRjd3JNdnpyeC8wZEpi?=
 =?utf-8?B?SDJnb2NlZEdOWmZsSVAycnZiRTQ5dEYyVWpiekVYa3ZxSCtnMWRuOEpnOFJ6?=
 =?utf-8?B?YTcxaE5oa0lTbkhwekpTbkdQV2crZEF5R2FldStSWGdxNmpvOWJSbFAwTlQx?=
 =?utf-8?B?OUVqNldHeVNnUjVTdVlNb2Z1L3pRSVhIeVROKzA0dzNOd2c1MWt4TktiNlAw?=
 =?utf-8?B?aHRRcWo3cFNsOHF0SEJpamNJcjlJc2RRV2FYaDloOWdZS2dQUno2WjIzL3BX?=
 =?utf-8?B?SGFkTUFJSHdlUm1oVkpjV3Z0bUc3R09TN3orSlVQRHkzMEljd3VubFRIREFo?=
 =?utf-8?B?aVRpdDFzeXY5YmZFaXlSbmtoRnM3dDJ0WEpHNzBhR1FLVldPWmNENkVPNkpQ?=
 =?utf-8?B?aTNDKzJRdkEvbDVweDQ3RHpldmxpV0Vqb0xDTnlQZlhCRVpEa0ZZUDFWSmx5?=
 =?utf-8?B?eXlDQXZudmx4eWRMbVF3clNWaEp1SFdncmNDd3dnam9BK01sZnNLRFdqNFF4?=
 =?utf-8?B?RzdPTFBrMGJrRk80RjBWNUJoc0xpQXRJVXRVVzVJeFBDV093aFB2QzlWUUYw?=
 =?utf-8?B?ZzdQVHczbGVTS1kzSTJmdXNsdEFPZEVpVFFFdUt6V1h6NWlQSmRQcUp2SndF?=
 =?utf-8?B?U0dDa21kYTJFdFQ3VXdpR0ZJWE5UWkhoNUI4RmNBSmRDN0V0a3hqemN3Mlpw?=
 =?utf-8?B?T1Z4YTRpT3dDcWh6L1dQajlaM0RLeFZ2anFsYm1GamVvYVRRWkFNanJHZUkw?=
 =?utf-8?B?emhHcmlJbWpKWSsrN3VlWVdWWEFaSTBXYnNQQVRmdm51V2oxeTNRNmpYUU5F?=
 =?utf-8?B?dGsxUUs4ZHg4RWV4bGtPZXByc2Z2VmVMUHBNbEZFK3Y1a3N1WmhzVzBtN0xx?=
 =?utf-8?B?TUV0emFsbWhHRjhNOVUxdWlLMGpFcm0xRzdpSnBtMnpHakxoSzQxVkptSXQ5?=
 =?utf-8?B?NnA0Y3UrNEcyOFlsWmorUE5KSnE1UWZrZy9hdnZjVzd6Y24yTlBRUVZXRGtj?=
 =?utf-8?B?aHNJRmlmNnZYTytqWDRzNTRJTkdtQVRCTVFBRWt5dTVVU2JmY3pUci9SdVFy?=
 =?utf-8?B?K3Y3QWdnSlNXV1MzZWhuSXgvUXVDcFpYS2dQRHlBVmhtMGs3STNsaTdMYzRJ?=
 =?utf-8?B?d0d1YnB0SVluTFRlb0tXRDJJMFhNRGJvSDN3NGtwUDRQeXE5T05tNjNONGxy?=
 =?utf-8?B?YnpMUjZVaWsvd0lPOVZ3NE9CdXE3SnVzWS9waVNndHM5K2J6K1ROVUdhZkpQ?=
 =?utf-8?B?Qk5pL0Roekh5K0VLMFcxNWdIT1FlaDhZMG5GZTFDQXdXZkFWa21RVzdjbHlt?=
 =?utf-8?B?ZFV5eVZFQ2NPVGd0RGJLaE5RckQ2cnBoSnF2aGw1U1BrcVdSUGlaUldyYVoy?=
 =?utf-8?B?SUJSYkhkMnJqNXVzdDZqK1lNSC9CaXUyTUVtY2xOWnNZNzMvNXdybFlydXF5?=
 =?utf-8?B?TUc2UHg4cWlUWGNKMGdGR1krTjBIZmpRNDhhZ1F3WG5FZmdlTVpDK05Camx3?=
 =?utf-8?B?YmlMQ1NydTMxeCsyN0VRRHV1b01mcUt5RzgrWnY2VVhlYStlS3FUOXZqM3VW?=
 =?utf-8?B?c2UyY0ZyQ21mYjNLbjdRREFHNGRqcThJZU9UcEsvM3MveG85a1BlYUI0N3kz?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7625
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 31/08/2022 11:30, Linus Walleij wrote:
> Pls keep me on CC for Kasan ARM patches, thanks! (Maybe I should add some
> MAINTAINERS blurb.)

there is one patch which barely triggered any interest, but the problem has been spotted during
KASAN usage on ARM ("ARM: module: Teach unwinder about PLTs"):
https://lore.kernel.org/linux-arm-kernel/2bb016da-363d-5aac-fe7c-066cfe52d738@nokia.com/t/

Would you like to review it so that I can add it to Russel's patch system?

-- 
Best regards,
Alexander Sverdlin.
