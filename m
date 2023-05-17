Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12266705BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjEQALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjEQALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:11:21 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E1F113;
        Tue, 16 May 2023 17:11:19 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GISrRq016155;
        Tue, 16 May 2023 17:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=QXhlJke8tgRaqyXvHpLWqKuWe+WD1xYD1yHylj/xVz8=;
 b=jyMO45koTtLgc2zSpK/S2dhQtamUwp8jjporBy8E38X0PbrCDiGHhxAgq5hJ3ZHX7+t2
 RtFQ54+1MiivaUIYNvTwMncO6e6HTWbCUK0locvbms0yvMunwOkI+7XVv75MIbVMSTtL
 BOLasRMlieWtppXA0neaFfhZxfLF5TDqHriQtor90UiRi03+nlVHQVhTgTLGEA0z23jH
 82Mpn50BM+u4zn3C2h4zrZeL7jCJjRjN+x4srDQ1sVH2CTv90y4FyGYVWpEMqH0+EbRR
 tqELCkQ0RQg0kYA5G6xJ3DIoZHjzq2Mh/y3dezVTcZMEv+IkiZKvsDt9/2KvWg65xKOA ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qj9t4rgx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 17:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684282277; bh=QXhlJke8tgRaqyXvHpLWqKuWe+WD1xYD1yHylj/xVz8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UF8pWDobC+Rrb304CLzrImvDNLsHeSsN3IW05sCJZ1d3Rc0b0a+lI7I18NHmLVekN
         Oy1D9jm0mESbGrnnelRNVfeDkJKDqcA+k+IGfRC2rwUCXOgdTpIUwTm3qEwAlr75KO
         Wdc6jc/JBJpOuIRTbLweJASsY6Nzd+yATkgn+KBd2YgVsB/mtG3Nf2JQ4HV9m6G6z0
         HUOpFFi1VQe30lK5lhtR0BN6hAjR9oe3DV8nqYlFKpzgn/Z7+EX5bkDU5JiFhYMAf4
         y+AZu5bO6GJYGG7vanwoT8P5ZeKCuVkOfq/ScefFwXO3sOW+ycQv5P8wgOx5+jBeKs
         TTcBPGCGl41UA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1082F40407;
        Wed, 17 May 2023 00:11:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A9DB5A005C;
        Wed, 17 May 2023 00:11:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iDipbaOi;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C06B5405C9;
        Wed, 17 May 2023 00:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMrKIExyd9GxlqNJYAc4MgnG0qlrTI1CteBCwLcN8hxraOBRyiSNsjkRVrwDzt9zUcFH2wVWKHlNmjKOJgTKiCOqDYSae7rS7pV3YULAX+2H3XrDce68nZPewK1VnraoXE/WEdqMwHM+Qs7aQRoxIo1US8ZEEKHPeuEXOITZVPvdxdpPF++5H0Kv0YZthqtZInZdqIpdgaRTizM2pBQAJCFMwUDiuUkOv4CgsRUhVMm0sjWB/LWWpT2P2ycq9q8EiVs26j/3LPyb8eO78V65B6w5QmcJ+GWQa514kOwf6A+EFbqeJypZemeltAgqCnobbGjkHl9wyB99s9ih+dQZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXhlJke8tgRaqyXvHpLWqKuWe+WD1xYD1yHylj/xVz8=;
 b=YTOoKrwMbN0fHMJceXGOlSiCFDYSoieTEoooRZWGbDwejzJHHKVC/7x/4dFjO9r5aBQ/IkH18zbJ2YW99aht5bi9Is/2Tg4tcmDONtTVlRw9Wc9ixbQ8g/ZXZoGmPnqohPgVVrePSeCJGI7gyETt2ScpBlzeIlLOYiKmy4IfD8I6P7c7/jDRQizjCcsQwDbTkic1HW6zoJc7d/y2I+gK0W1FhU09KjiYJEbVl5q5pZIweertax/mi+Hffu7D1ka0b/BhX/rf5t6Mfoc33MtJuoYv/0mhuOxu5Y08uU7vs+NZg8Jc9ttODdKhxXXmpOgYDcHyxpC+dZCBrVdgwBUhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXhlJke8tgRaqyXvHpLWqKuWe+WD1xYD1yHylj/xVz8=;
 b=iDipbaOiVm2u3TDxmtWiywjIaH7IiewlWJ9MPAMIkowfYc+/Qwp0GQIWlvWrz2xLZqytqjmzhaWIaACwo7ZjjJ5jRTlwbw3mg8ZaKXSNRAHxpWyanawDiC0TsAeMUgm9TxPGJMBcheCMyRNFguL+g6XWnh3F543oBlNQP071824=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 00:11:12 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 00:11:12 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Topic: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Index: AQHZhnOYGWoDiciaPkad/64K3wvwX69dmz2A
Date:   Wed, 17 May 2023 00:11:12 +0000
Message-ID: <20230517001105.v74dyo6asqtcrpii@synopsys.com>
References: <20230514145118.20973-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230514145118.20973-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB5629:EE_
x-ms-office365-filtering-correlation-id: 76bb81af-71a9-430e-1389-08db566b392a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KForctl+H1RgafnLCw4LxMp2t3Wp6IC3iC57orjO7NuzGZM1XQ2fQKAYfMVvBmZ6Ibk4hoZKjEq86pI6B754/ec1/Trl39C1srOZElVi3iKXoecSiJi6v53BYgEwvL5D3S7OBxEEVl3NxYitbS+qSevGGDFboZjaPNT89LVbNOjuWVmmLtUMamp+1g+Hk4h+iwcss/4Fm0vryVk7SuvnIAGkeZsx4RlOUxVgmT6Gh4qRdKM5T2x62EMToeiPNdKAeIXXruEb0AGH0x6ouXcCI6mg1fqxlv/cRCMhBBnge9gQf3Zqvtc8ciTjebOsNaIuFF5XgIW1sNQQBFbKFIj8jZOjmHxL8qwUUkMDyLjecCR9riZlGaqGk21PlRjpZJsmANY0W4uhKtSs3Ls27f/GIw1LJg40093NyI5oknu8ztx6Z2XuhbFyPS5gF9v42D0XZbVwE+5+9Qx/Ht/AtetlDvByMg1rKEv9bEmQK09hHbKkzyVpBibkovC+e4ik1AfjNU2CovFBtMsLMWIhanKduATnj7Se3BJSEe+Yosqf9wUICClLVCBBJ2/XB59ztkc7jKj0e1BLa8FIXbkkCpyThLsOSE8cwr72lRUmNQDEdr96Bda5Xu2ru647BsluVVnJXQxt61TxdspLQstLwOmBPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(5660300002)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(4326008)(8676002)(6916009)(478600001)(54906003)(2906002)(8936002)(6486002)(41300700001)(316002)(71200400001)(966005)(1076003)(26005)(6506007)(6512007)(186003)(83380400001)(2616005)(36756003)(38070700005)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFQwQ1NnaXBLZFdiVm9FNHcxZ04vTXJsREtGY3FsS0RBbGxGOE9wZDFvbW15?=
 =?utf-8?B?WlYvdW5Ja1BkbUxPZGJBbEhoV1JFRVJsV0FEekFsM2pFMTJwVGN6SUhYWGUx?=
 =?utf-8?B?T0VMMlVhdzBtWEJ6OFh6WGIvNzZqSlVBS1k3aTJ1OUFvbHd6REpibWR4alJo?=
 =?utf-8?B?MHZHaG5pS3pVOWFTVDVOc0dhUzFqSG1YL2xnSWRONkk4WkRpWDZBdS9RTlZP?=
 =?utf-8?B?UTgvMWloQ3BraUpLbDVyUkpYT0JQMFBQT0JONkN6a3U3Rk9NVEVSSysvSGM0?=
 =?utf-8?B?L1o4dFVpL1NMcHUva3E5TmpUSndGMmMwTjk0NUNJekRDZ0xJcDBmUU5sbWtD?=
 =?utf-8?B?L2ZlcHNZSkNiK2hrWVFTSjRNc0xMbHRyQVhSeGNLSDdad0NsZFB0UFVNZHE3?=
 =?utf-8?B?N0JpVmhoOVFIaXJnRDZBYzdSd3FDb1BGbWhoSWtMbTNXN2N6a00yYjBWTS9p?=
 =?utf-8?B?cTJ2cjRjVEZFQ0QzRFBqSkEwQkE2K21KcFF6VE51WXVkZ1RidGFybzF5UWVJ?=
 =?utf-8?B?aXJEVlE5Snh5KzF0MlYyN3Jad3d4VUFGYTFYRjFKNUIzbFp1dzVuNHdtdWtH?=
 =?utf-8?B?Y1hwTXBYam9TdjY2ZGMxNGhsVUxqWjg5VFY0elY1Tmg3M1ZueGoxVm85Ynls?=
 =?utf-8?B?Qjdzc0UrelRnbEI5eGZxR3BXb3U4WTJaWmhuUHFpWkJ4ZXNtMXM1MHFXeFZE?=
 =?utf-8?B?a1ZHNTdGWkFQNFNFL2pER1dVMWswdWVPOENZTTd5VnE2dGVmVkVwR2dPbnpt?=
 =?utf-8?B?Y1drS25IZG9saElpanhHZktyZFNZeFVFdFRlVFI5Q1VVd3hYdGNINC9teHF3?=
 =?utf-8?B?TUdqS2VOR2VveGtITkpHayt0V3FJOGs0emNZTmpSZ3U5ZXVlUjlwZnBMRkZC?=
 =?utf-8?B?MytkaS9mdGtxVVQ2S2p4Z3cxWmVCSjZSZVNMQ2NBU2J0d3ZoVHU5TU1Sc3I3?=
 =?utf-8?B?eWQ2RFd1VXY3MzVnbDBNcGhuY04zbFNUWFhyWHdaSjFxcjY2ZDVNSy9nbWJG?=
 =?utf-8?B?RkN5SFpsMVpudEpKRVZwMDZBQkRlYVZGVEJnUkk2YWdPM3psUmVoSzBZSzBz?=
 =?utf-8?B?WkNiaFkyYkFUWDF6Y2ltMXFVZ0hkOGlaY3dOZGNDajFVckFuSUxiU04rNzlq?=
 =?utf-8?B?WTFFVVV5UVc1c2FsQStKTlZQeG12b1BSeUhwNklXeHo4dmxuV0ZaNXprQzU1?=
 =?utf-8?B?RWNtalptV2RiSk9pZno2cVR1dnRFa0xSeU4vZ0ZPOWlHZURyajFOTWp3b2J2?=
 =?utf-8?B?VXNRSUJwTGtZYXBtV1d6Qmk4YldycDVDZnhxbUgrNFBNRWRrRjJHMi91dEZ5?=
 =?utf-8?B?TGdLaWwyT0RaaXBhcXZ0TE5JajE5OElOaXd2enU3ZTlwZ0FZbW1zRk1jOXBx?=
 =?utf-8?B?VmIvN2g5d2wzazRDZ1VPdkwzMCs1bVZMaWJMd0U0WklCRVhSblJyaXNSOFlM?=
 =?utf-8?B?TlU2NTI1MnRTOS9BWDZXeW8xSFlpcy9vSGhWMXhDazIxc0lHMmFJRGg3Wnk1?=
 =?utf-8?B?ZWlaQzRSVmtyMERjcEt5Znl4eXJQUFpPbTdiZW5CZ25WeHBVNEZhaUQxNm5K?=
 =?utf-8?B?R1pzeTZJMnRnKy8vUEZwWXBKTmtDZkMyckd2ZThzZGFqUXJQdUFYQ29Yajg5?=
 =?utf-8?B?aTVUTGMwdGoybzhPU0dXcW10ZFJIRnpiVC9FQ0QxbWdNaWNXWjdlL0dhOVJt?=
 =?utf-8?B?TGs2N04veGFkVy84T2VTS0lwTXJDVFJyc041bEQ1bmNwdGovTDJVYUpzQUxl?=
 =?utf-8?B?c0RkR1llVC8vYlBEYktiaDA1TWxWL3hhM1BHUzVFTG54ZGl1Z1ZsaCtraXd6?=
 =?utf-8?B?dXpxdFpmdDYrS1Y1YlNkS3BKL2RSU2xkRjc1N3ZyeXh3ME9PYnFlNnVlM091?=
 =?utf-8?B?Y0QxSXNSbkVkdktNOFg1UkNkTHhEWm40NEE3cm1LRXNCakFaQy91ZmZVb2RU?=
 =?utf-8?B?eVRiVnFvcExJMlJCMnlsczNZd0dCZHpMYVgwc2JTV2J3b2d6Z2h3dlBaTUcw?=
 =?utf-8?B?L3ZlLzRmdTN3WGlWUmtOKy9TMDlHUUpTbTU3YWZBRGdxbFNpVkFRYmFhSWhL?=
 =?utf-8?B?b2hnd2FxSk0xLzBUWkkxMlpSSStiUkI2a1diVUdBVGRaTWxjN01hMXBucXdq?=
 =?utf-8?Q?V21uV5ENOdru3SOLTY1QFwxhK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D9792CE3EF2A54CAD64A55C26F7DB1D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BR/W1RwRHQCQsf+QzASEJ6u4UzGuTBLRtXFvk0R800INMwIQ8hof56yGC44Vugr1S0lAUqJhhZHcTdUHkugP2MqerQSpwrFjTqGS29pxKBIFz8zAjYR8EvlEAaU9Ho253pwNzmFwBTtlOwg0D3fjIW5Sh1CkRxhZ5nI9cjNyQhYIxHjhNhveyCpPY/LMoEigixropYLwgTaPaEErOxGiIJUhL/xrHWAOiQTVXGjaWf3+mNFxSq5BcmRiFyP9nmAP1sr2aG4JtN9JjjQze/UAZZzV8tQrT6hGTzJ05ncHKcymvElFbSlttIX5IwzcXhUy9Bt106ZygS2W22XRX13FRk7VxqOAI2sDY2jr2dm374OCv/hahnUo/zo/IbZSZjuvUsbMiuOId4sQv1zmWavVTA7QaoMYhuCZa6R0vvZSpSNDY/C/hIZu2uhV4Cl+PMeb6jfD1Fz1pygaKpmKYt61E16Dc3U8K6Uoeq3qphDAykLNAhh4q7ylwvw0McqXd3K08CoV/TX5DCuLzMstxwWP/56Vif4olj/j2yM5Q9u0RQkvKC7/rcltHwkAHDjDExnk1RQ5MVP/sDtxRO1eUL1MTFct8I2waC+CsiSkkXjtKGJPDbZue9vsH3GhMn4ZiEp/aF0pJOI81uR4NJD9ReaTMtlDEeRbfbilfQI+B6B/Gr/Ef77nVnt/ZRKd6BdyRlAcPRdUUckGmedXAZw8L47pPr6Anqw5GJdzRwYTg2eDq/UMjqdO1KJPznX31rK4ny7+T5h1af32Bu0bSBwcWY5iU3vYABNjuakP99iBahSfi2Upo7DVdFEsnNHSGq0KcPY6dMfV1M/Uyo/6909fE7vpZbuLv8xoWQN2RURco+FZ4iaxDTDqVJldVYTi8v0wjH7xgdbc9oVrWBrM459EBUEQrg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bb81af-71a9-430e-1389-08db566b392a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 00:11:12.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dw+fhEs4n0R9qFWe9WyMuTcbv4LiZu7RFzbMrd/98Eq+4lm83980vwNZ0VRtnDE9O/zHuiB8N7aS8qX10QtwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
X-Proofpoint-GUID: IsPyYoCkoDeO6XPEerTFsko1LC4QOAXU
X-Proofpoint-ORIG-GUID: IsPyYoCkoDeO6XPEerTFsko1LC4QOAXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_13,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305160203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBNYXkgMTQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBmb3IgZHdjM191c2IzMSBjb250cm9sbGVyLCBpZiBtYXhpbXVtX3NwZWVkIGlzIGxpbWl0ZWQg
dG8NCj4gc3VwZXItc3BlZWQgaW4gRFQsIHRoZW4gZGV2aWNlIG1vZGUgaXMgbGltaXRlZCB0byBT
UywgYnV0IGhvc3QgbW9kZQ0KPiBzdGlsbCB3b3JrcyBpbiBTU1AuDQo+IA0KPiBUaGUgZG9jdW1l
bnRhdGlvbiBmb3IgbWF4LXNwZWVkIHByb3BlcnR5IGlzIGFzIGZvbGxvd3M6DQo+IA0KPiAiVGVs
bHMgVVNCIGNvbnRyb2xsZXJzIHdlIHdhbnQgdG8gd29yayB1cCB0byBhIGNlcnRhaW4gc3BlZWQu
DQo+IEluY2FzZSAgdGhpcyBpc24ndCBwYXNzZWQgdmlhIERULCBVU0IgY29udHJvbGxlcnMgc2hv
dWxkIGRlZmF1bHQgdG8NCj4gdGhlaXIgbWF4aW11bSBIVyBjYXBhYmlsaXR5LiINCj4gDQo+IEl0
IGRvZXNuJ3Qgc3BlY2lmeSB0aGF0IHRoZSBwcm9wZXJ0eSBpcyBvbmx5IGZvciBkZXZpY2UgbW9k
ZS4NCj4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIG5lZWQgdG8gbGltaXQgdGhlIGhvc3QncyBt
YXhpbXVtIHNwZWVkIHRvDQo+IFN1cGVyU3BlZWQgb25seS4gVXNlIHRoaXMgcHJvcGVydHkgZm9y
IGhvc3QgbW9kZSB0byBjb250cmFpbiBob3N0J3MNCj4gc3BlZWQgdG8gU3VwZXJTcGVlZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2lu
Yy5jb20+DQo+IC0tLQ0KPiBMaW5rIHRvIHYxOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNTEyMTcwMTA3LjE4ODIxLTEtcXVpY19r
cmlza3VyYUBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchZENnXzNXSzJvTlhOYjZkMGFfVnV5
amtlZVpKVFUxYVk0ZGlrNmczNVhCN210RzdFSmVSMXVQTWZ4RmphNDlPZlhwN1loc2cxeXFqbnls
Q1lZRWc3WUNBaHFmQVowUSQgDQo+IA0KPiBEaXNjdXNzaW9uIHJlZ2FyZGluZyB0aGUgc2FtZSBh
dDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9lNDY1YzY5Yy0zYTlkLWNiZGItZDQ0ZS05NmI5OWNmYTFhOTJAcXVpY2luYy5jb20vX187
ISFBNEYyUjlHX3BnIWRDZ18zV0syb05YTmI2ZDBhX1Z1eWprZWVaSlRVMWFZNGRpazZnMzVYQjdt
dEc3RUplUjF1UE1meEZqYTQ5T2ZYcDdZaHNnMXlxam55bENZWUVnN1lDRFJMVXJKV2ckIA0KPiAN
Cj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgOCArKysrKysrKw0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggfCA1ICsrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDI3OGNkMWMzMzg0MS4uMzNiYzcyNTk1ZTc0IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiBAQCAtMTI2Miw2ICsxMjYyLDE0IEBAIHN0YXRpYyBpbnQgZHdjM19jb3Jl
X2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiArCWlmICgoaHdf
bW9kZSAhPSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9HQURHRVQpICYmDQo+ICsJICAgIChEV0MzX0lQ
X0lTKERXQzMxKSkgJiYNCj4gKwkgICAgKGR3Yy0+bWF4aW11bV9zcGVlZCA9PSBVU0JfU1BFRURf
U1VQRVIpKSB7DQo+ICsJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0xMVUNUTCk7
DQo+ICsJCXJlZyB8PSBEV0MzX0xMVUNUTF9GT1JDRV9HRU4xOw0KPiArCQlkd2MzX3dyaXRlbChk
d2MtPnJlZ3MsIERXQzNfTExVQ1RMLCByZWcpOw0KPiArCX0NCj4gKw0KDQpQZXJoYXBzIHRoaXMg
c2hvdWxkIGJlIGRvbmUgZm9yIGV2ZXJ5IHVzYjMgcG9ydCByYXRoZXIgdGhhbiBqdXN0IHRoZQ0K
cG9ydF8wLiBUaGlzIHBhdGNoIGNhbiBnbyBhZnRlciB5b3VyIG11bHRpLXBvcnQgc2VyaWVzIGlz
IGFkZGVkIHRvDQpHcmVnJ3MgYnJhbmNoIHdoZXJlIHlvdSBjYW4gY2hlY2sgZm9yIG51bWJlciBv
ZiB1c2IzIHBvcnRzLg0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4g
IGVycl9wb3dlcl9vZmZfcGh5Og0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAxOTY4NjM4ZjI5ZWQuLjVhMjUx
ZGEzMDlkNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTE3Miw2ICsxNzIsOCBAQA0KPiAgI2RlZmlu
ZSBEV0MzX09FVlRFTgkJMHhjYzBDDQo+ICAjZGVmaW5lIERXQzNfT1NUUwkJMHhjYzEwDQo+ICAN
Cj4gKyNkZWZpbmUgRFdDM19MTFVDVEwJCTB4ZDAyNA0KPiArDQo+ICAvKiBCaXQgZmllbGRzICov
DQo+ICANCj4gIC8qIEdsb2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gSU5DUnggUmVnaXN0ZXIg
MCAqLw0KPiBAQCAtNjU1LDYgKzY1Nyw5IEBADQo+ICAjZGVmaW5lIERXQzNfT1NUU19WQlVTVkxE
CQlCSVQoMSkNCj4gICNkZWZpbmUgRFdDM19PU1RTX0NPTklEU1RTCQlCSVQoMCkNCj4gIA0KPiAr
LyogRm9yY2UgR2VuMSBzcGVlZCBvbiBHZW4yIGxpbmsgKi8NCj4gKyNkZWZpbmUgRFdDM19MTFVD
VExfRk9SQ0VfR0VOMQkJQklUKDEwKQ0KPiArDQo+ICAvKiBTdHJ1Y3R1cmVzICovDQo+ICANCj4g
IHN0cnVjdCBkd2MzX3RyYjsNCj4gLS0gDQo+IDIuNDAuMA0KPiA=
