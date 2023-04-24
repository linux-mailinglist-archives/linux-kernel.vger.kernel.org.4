Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF06ED6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjDXVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjDXVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:34:28 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504059D1;
        Mon, 24 Apr 2023 14:34:27 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OJ6K7X014847;
        Mon, 24 Apr 2023 14:34:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2YxUM040SQIAe6+v/h2aH7mNyBeWRzXPuG7Yy+6YSBw=;
 b=ZogdaYuc6Q599Xc+f7qUwsG5C2o+y9+4uM4xv5UB29zPCY9KSrV1covKmYxkDyUfBO4J
 Sj3kShKpj9fHHjCCJiWkgvw1V5alQRHzm0FxfMKuf3JEzoXn10zGVlyK3IwoCfOAyfMq
 rT+AmWQp3vw/vvIihYx0+Uo48Nc1BsJ5r2u1yEW2g7GHYBS6LDG+h+k+z8lOHj87pnjR
 AuaaUf0H35d12ulGvmZxTAtIxlWY+8VHEBYmo0+72jFmw9M/4T8wEPJgxTgrTBepxCw6
 jSiGb+pFyaomm7niKzk/QqZBsVGF4QCrXKBrcTubbTDifkWykNS3V7aXUajvu5EmlF+l Sg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q4egv8qrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 14:34:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682372043; bh=2YxUM040SQIAe6+v/h2aH7mNyBeWRzXPuG7Yy+6YSBw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FNH+0VoCKua3QpT29qXRwtC63dDPn8odPz4vF3Rm+iqv+U7bxT1KRh+lTNj6nybZU
         znx/L79UYrKTMZlxj/RZ/zHsYgpSwJr+3dpzUf7ycZ07k+WSSihLAN7k7YZh8gMFYd
         ZBZuREK1ic1waJdT09ojIx22BdCnpgE47imGjUlnmkg5n9bham7D6yAtZTdRMFPTwE
         nsmD8nMeCn7RAA4g1Mvfc40s09b/PF9pbKCMO6ezBg3Qv+COlasZxUCbdtpq0zdRfA
         seAN96ZnBX2pw4qPc+BiHYShxiAO9s+AdBViR8ACIjjmplPVjchAJUru8RYmWWX0nr
         aJWE6RtoAHttQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C193E40520;
        Mon, 24 Apr 2023 21:34:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B61D7A005A;
        Mon, 24 Apr 2023 21:34:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=G4+kj5qd;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CFA3F4061C;
        Mon, 24 Apr 2023 21:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKiqTIuuy5xs7U2zWt02G6ZpTeygyHxZ6C3dMCBu7erbiIi2QgA7crJ/hAEq8x3RUoR1aA6Ayv4SfG6LkYObVyKAfbUqgTDinvVUXKQgRdvLzpXg93iSuDMmxdLZEf5gQX8saVS5oLTdvhdjgv2AP73Jy2YgQV1wK7eMwbX5f/qWJo4KKUlsPAJqYpVUhzEBsQCJMbEPXTY+Lz2eEsyX9BgRCMbXcvCnb/6EAOySvi7YXSGXJZoZNuRsmrQ0H7L07JFZLim5f0+/7/kN8VhMld8dYD0cN+yMA2ozeqbwMjM8B1Z+QC3oyW3deflUyePZLisZMMMcUknL7qorEz5vlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YxUM040SQIAe6+v/h2aH7mNyBeWRzXPuG7Yy+6YSBw=;
 b=Jn22D5l/eh3NC7iicElngTh0RWaRvA2cswkvZHFOV3OvWM1D7W4vYH8LIilcBScTFRwYxKb9ULb9B5sq5GK/jzvRoNBdSkPqdHYmrmAba7k/sSZcABNhbDmydnRfcP/+qfo369s6cp+QhgHE1p1qw2rhNgbuzR0QQ2MKGA46vpMnuNgN09ECrsbnEu1zNA6AjpuHOYFs+dBLKT4xDAuKLooE7Kw2qPEF9fW5+XB5yXGoKl7NrxCKdgMRnowLRjYu6IJ5DjGon6P3Glsuz+aWmSRJxR32Svo1h00+NlNsJlsx8EzU4x4WbIcj9iExSyum+yApFtMkkz72u+aoqokXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YxUM040SQIAe6+v/h2aH7mNyBeWRzXPuG7Yy+6YSBw=;
 b=G4+kj5qdH9XDDZPHkaRvLFpeuM8PxWjVXSQjlZLsQ+LV3ye/9EMo0/Vji6bkBVU04fvNvhFd6AA+9irtO2qy/PcewqOE9+HzrkyIcyhrwYJkwpp9sgTKLtBJzYZx6gXL8LrXL0es2Fzn/1PxHwIMsfPaLhkOkDde85tZDZ3Wc7c=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 21:33:54 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%7]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 21:33:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     lihuya <lihuya@hust.edu.cn>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] usb: dwc3: remove dead code in dwc3_otg_get_irq
Thread-Topic: [PATCH RESEND] usb: dwc3: remove dead code in dwc3_otg_get_irq
Thread-Index: AQHZdpvtpyf3u3v6SUSQWFEt9heg/686+6aA
Date:   Mon, 24 Apr 2023 21:33:54 +0000
Message-ID: <20230424213339.avocjfchjd2ptaqg@synopsys.com>
References: <20230424105930.49944-1-lihuya@hust.edu.cn>
In-Reply-To: <20230424105930.49944-1-lihuya@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB8007:EE_
x-ms-office365-filtering-correlation-id: d83734f7-c9f1-41a5-845f-08db450b9a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: It2rskG4Q6OflvrAdd2/TF5uI5FWtCNw29YX46+hoXYgCGqqvI0v5dNFt6nfXnQpC/c3sQDjRdI/D7mo5FsW0aTpHt0BL9O3Zb0KAMjORJupbrWOD0w0JQkYdt+xdFYrDfIYfHXcODO/YXHbzaeS7CkOo6/wV6YKjXHTqEZYomzPh0SqGsfdTszG5YwrWqWGjjKJXJs9O4I0j5KKqEu7B6/EhOlRQwyqDh0KgZTN5jNtHVD4qQQQ6xx5Gy324m38OEg8wPIBIbEmQYEGvQtcr8gGWhY2CMRA5RyHjZao7CQ2++sGHBZqPHw8qYKEVGp9DGuiQ8m7+BGA2WvAXtDUwT0ejG7FSCOSYBkDaz4cQnI4ge0bFhV+DN+fA4VljEMbF+xJuokisaxxaIUtn64cEtdrlEz/jDp1i5MuSmz6kOZEiLulFcXsDhDM9saLy9YP4lhZycTpAeYUqV0+DI5OwicCwKgEP1ET9ASXGMrYOEVDdXVz4yYgoeP+GnndLvd2vJ1NXx+FiE0QXnbkKYMCy97YdozROsRP9oZZDrxXXI3UK03la26y6096mBSLSwcwxIbjgPlb0QJ177QyMt974O6lxnjFFsyoN41kKDxp7kp8Nlt599PChNFE/oAKpKI1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6506007)(1076003)(26005)(6512007)(38070700005)(2616005)(36756003)(83380400001)(186003)(122000001)(38100700002)(66946007)(478600001)(76116006)(86362001)(6916009)(66556008)(66476007)(66446008)(8676002)(8936002)(54906003)(64756008)(5660300002)(71200400001)(6486002)(41300700001)(2906002)(4744005)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGNOUlJUOFRqZFgxMDRkVXFNaHZZelkxUEJWWU9ta241UG1zdVI2ci9xVThl?=
 =?utf-8?B?ZW03YVpER3lEMkxjSGFpQmhDeW11T3VVYS83V1dvQWYvNlVoZmNidTVxUFVF?=
 =?utf-8?B?Q1gxVW9LQWVJOWFHNG44WkVVSzVPdlUycWZXdGZ6UUdYOWUzMEc0UFdlWWZU?=
 =?utf-8?B?SlF2d2NzeDUxYnd4T1VDWERaSzlEbnRMVmhnOUdyVlRjUkxERHRVOEkzbC9D?=
 =?utf-8?B?SGplVXozbzJFNGc5S1hodzZSN0JhV1RSVVkrL1AveSsvK0U2T2NWQnBFVVV1?=
 =?utf-8?B?ZjdMSEhNbzlmcW9aUTRCcmRuTGpiUDRTU0pqRDQ2STd4L3k0ZVFFTzlJVHZr?=
 =?utf-8?B?VVg0dzdzbXFqZndCYlVINURQVHZGMDBtSjFFWDljamxrcEpOd0VQWXRUYmFM?=
 =?utf-8?B?S0NXU3h5aHlEa0xqY0dDVUxVRlBIOHlUUkp1bnJhMjlxWVZkRXkrdksvUHVG?=
 =?utf-8?B?aWRtK2JMTFlpcFExTjhCQlFJeUlGVWE4TjdxMm42UU1Fa2RqeTVobXY1WE5W?=
 =?utf-8?B?SlBnbEVKeVNCUnBaS202d0grS0VySnI3RmJkMkhoZVA0NGxGdXJNekhBTVZm?=
 =?utf-8?B?YUNsQUhQTUtCUktWSHV3SGJZWnB4bmxNYWdXdmJGM21iVFBxOWJFbWx6cjRC?=
 =?utf-8?B?dm41QU5CL1hLcWpicm5yL014QjEvb2J0dE5mMXRIWXI4K0NjVzZHKzVYYTE1?=
 =?utf-8?B?Z1hYVUxRVlRqOVdIekVXU1JiQmMyZjJmWlh4dFlwbk42b3F1KzBEUzI5ekJX?=
 =?utf-8?B?N3VIRW5qUUNUMEc0MkNXeUxqM2RiVlNPMkpWMVNtTmdqdVB0cnZqSTkvNUxC?=
 =?utf-8?B?cExEbzhmU3Zra0QvUVNRRnE2bUZMRDhlRmJreGpSbGtUamVQTi9MbXBTTDl4?=
 =?utf-8?B?Y0k3S3pCdWt3RTYxU2p3alVBNk5GVGhtWjN5RjNmb1NJcFZIMVJTOWQ5WEtw?=
 =?utf-8?B?OFU3U01Obk1OekhXeHVKdnBBL3FkQk1pNGRiYk4wN2pMY0RvcGVES0lWSTRZ?=
 =?utf-8?B?RGQrc0lxVjB1WkxYTFViU3FIdHExVEVoci9aczE0aGcvYzB5ZzQyS00wSWdC?=
 =?utf-8?B?NXIzTzhkL0loRUUvUkc3SEN5clhySU9vNGdRS0hOK3pqczJsQ2xJYWErSFM3?=
 =?utf-8?B?aTVIRlNMOGpGUTFSdC9TQUo1cER1NEEyV1BwaFBYUGF2cHc5VGtpd0RZajV6?=
 =?utf-8?B?T0lJZTEwK2pPaUI0VElEc0NnUEw5cGxyam9MM25JYnBaMGdLYkl6L1JCY2J3?=
 =?utf-8?B?NmlFbHdjNzVZT1MvbjdWcGoySXI0ZWw5OEpjUW04UnorNmpoRTRHZWNyQ1lS?=
 =?utf-8?B?TkdLUlJNb2JJNjR5UE10RCs5ZVNJQitnbFVmMklpd2tqZktHSzJ1czBYeXlM?=
 =?utf-8?B?TnVMVzNtb0swWktnRFQ1T2M2UlZ4SS9pN0swUEE2aHVZaGxVRXpOOFNrUFNQ?=
 =?utf-8?B?SmhhZVAvTVUxZE9DUnFpTUdJWXlFdFpGcTltS2UzMWlMYmNzV0dZNHVyb1hp?=
 =?utf-8?B?Mm9vRTFjQkdLSnpCRW5HRzR2YnJIc3QzdUg4cGVnYVFjZXo2aDZxZHJOTGFx?=
 =?utf-8?B?bUEyMytPWlA1Wlkwc0VkeldXUFByV25adXZ4UWdZN2xPZEQ1S1hxYTZUcG9z?=
 =?utf-8?B?Y09aRjI3eVZFaldURXhRektnOWhZTzB4OFgzQVNyLzdWczhHQ2c0Y29laG1l?=
 =?utf-8?B?UGgxMUNJWXVVQnZmTnJUY0tYdnhSRzBzTnN1TTVnYS9GeWxLZ3NnT0d2U0NG?=
 =?utf-8?B?NTdtKzhRMllKcU90Z1RpaEVUUEIvSnpQNUl6QlcwRnJsbmF2OTJIbFZIZC9J?=
 =?utf-8?B?TEVmektNUHNvWUJ5WmgyaWZYS0JkMm9Odi9nQzFrVC9pWE9hZGMycXVkYlVs?=
 =?utf-8?B?ZUNESjFCbUV5OEFuYTgySVBhcUhHTUdmUDZ0cE8wU2xqbndRRWNuMmUrK1VD?=
 =?utf-8?B?M1dGZlRhc3FhZzBHZVlXVHd1aXYxd0xhM2R6d0ZxaGNVeEtBT1hhZ1h4UXpi?=
 =?utf-8?B?V2gxSVV4dGFxQ0ZxSlhkYVQ5M09jdGtNSis3NGJrWW5hOThjR3BiQWZIUGl4?=
 =?utf-8?B?VjgvSXAyb3duYi9kdUI0enVwa1pBbXBSMDdWNXNNNlZFN1ZUbmNpaDgvdk1N?=
 =?utf-8?Q?TgihW3sNdLRLtA+ekqqAGdrm/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DDF6C13C9F6A8459F6B725EB4E78256@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WWJDWEhjak5ueGU2SnRVS1VxaCs4b0NrWndYVXA0UnNuZEtyZ1VlREN5WEQx?=
 =?utf-8?B?T1hXWURXVGRyN2hKVXNaQURNcGUrSktZSExldHh0Zi9XNzVxQXpVcVplUEgy?=
 =?utf-8?B?VGR5bk9COU9JVkZzQXk1NTJFR0JsRkl1YldmbzYwL3g0MlhzSjFWYnhrVklT?=
 =?utf-8?B?bnY5aFpmMk8ybnA0ajZMK0JUdzlueXowR1hKcE9qeUliUko0dEhrN0k2elR4?=
 =?utf-8?B?eXZkN2dwOFZicGpQeml4YVFMVFpPUWxHQzg1a0ErNm0rbjBkUmp6TjR6Y0ll?=
 =?utf-8?B?UGRwbmJMUVVjYWNzQkRFUVIyeVg5cnlEbzlXRDQyWHFzcTBMRVhva2x0Zk1T?=
 =?utf-8?B?Mng2c0FRTW1Uekw0V09qTEFuRldrNU5XK25iZVFmMFRQcXF5YWFScmNKbEFD?=
 =?utf-8?B?NFFBUHFDbDdxZmdobDlkT3RuRFFMVWR2UUN5enBKMHdjbS9qd0I1dXB6aldJ?=
 =?utf-8?B?OWsxTXBDSlVWbEpCbWF0eExGM25GUHU1MGxVTzJXRXZEckF5ZEFQeGlCNk42?=
 =?utf-8?B?eWFoTmFRSDNVd3BtMFJ5YVFwdjlrYjd4bGtXRVBkZHdNeWpCdlZQQzJFU0E0?=
 =?utf-8?B?SjNxQWozUEVVOHVORSs2MTAzTHRNUzFNMnh1SFNYZ2xKSW4vVEdka010bEhE?=
 =?utf-8?B?c1BVekdkWGQ5Y1FJcS94Yjk5ZHBmZmNDUEtxei82Y0ZoelNSQnZzbFdHVis0?=
 =?utf-8?B?OTJtdUtaeTBJZ2R3VTIrMG02aUY5S0xpOHJ0TzdSbHVMRWVlQW5RL3dFYmw1?=
 =?utf-8?B?ZjlWWndqMDZreWpVMjZtYmlZS2R2b3Q0dW1EclNockRhT0U2R1hNRmRIOXdT?=
 =?utf-8?B?NFg5bVJNYTdycitFUWJIUHU0aHozWHJvYzY5cVRJekJWK1dBNXhRUDRyN3NK?=
 =?utf-8?B?UDA2RTdrSmZqb2RBNm5IOVgzeXVvbUNwYU9sQkl2RWF4ZkdlVmlLeGhMNksy?=
 =?utf-8?B?NVN1VU56akJOVVdEMFlNcTJwYnlNWFdsanJBR1gzUXI4NFk5cWRwNkxudzVx?=
 =?utf-8?B?cHFqUjluNGwwSG01NW5tak1IT1RIT292bmNLa1FMRzhlT3gxNFN2WEZwYTdW?=
 =?utf-8?B?cDQzdlp2YzRJMDZiaCtPK1Z0ZVMwNTF2WGEvM0cwY2x2MElGSzVKblFDYndR?=
 =?utf-8?B?aWFJY25MbGlpZlNmanhocWdvNVpCZDFkNXlCTGxidHZhODRZY2dRbithTTZj?=
 =?utf-8?B?OHZ5TFp0c1c3amxEdGMrOWpFWGNiYWdNNS90NUt0VHF1ZFNCZ2VVNENMRFQv?=
 =?utf-8?Q?9AC3eEBCoF2T8JE?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83734f7-c9f1-41a5-845f-08db450b9a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 21:33:54.0561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dr3MkfdjNkaScW1yuYgFBl2YDNamXK6rKTmtu0UqWlHET73VTYqA1OvuXP8SY51Oi9eNrawSd/1MnsRglrLE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
X-Proofpoint-GUID: AkLjhu94iwS10fEEArhPYLrikoCyGXGh
X-Proofpoint-ORIG-GUID: AkLjhu94iwS10fEEArhPYLrikoCyGXGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=897 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMjQsIDIwMjMsIGxpaHV5YSB3cm90ZToNCj4gcGxhdGZvcm1fZ2V0X2lycSgp
IG9ubHkgcmV0dXJuIG5vbi16ZXJvIGlycSBudW1iZXIgb24gc3VjY2Vzcywgb3INCj4gbmVnYXRp
dmUgZXJyb3IgbnVtYmVyIG9uIGZhaWx1cmUuDQo+IA0KPiBUaGVyZSBpcyBubyBuZWVkIHRvIGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgcGxhdGZvcm1fZ2V0X2lycSgpDQo+IHRvIGRldGVybWlu
ZSB0aGUgcmV0dXJuIHZhbHVlIG9mIGR3YzNfb3RnX2dldF9pcnEoKSwgcmVtb3ZpbmcNCj4gdGhl
bSB0byBzb2x2ZSB0aGlzIHByb2JsZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBsaWh1eWEgPGxp
aHV5YUBodXN0LmVkdS5jbj4NCg0KSXMgdGhpcyB5b3VyIGZ1bGwgbmFtZT8NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZHJkLmMgfCA1IC0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jIGIv
ZHJpdmVycy91c2IvZHdjMy9kcmQuYw0KPiBpbmRleCAwMzliZjI0MTc2OWEuLmMyZTA5NzAwMjEy
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kcmQuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2RyZC5jDQo+IEBAIC0xNTQsMTEgKzE1NCw2IEBAIHN0YXRpYyBpbnQgZHdjM19v
dGdfZ2V0X2lycShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlnb3RvIG91dDsNCj4gIA0KPiAgCWly
cSA9IHBsYXRmb3JtX2dldF9pcnEoZHdjM19wZGV2LCAwKTsNCj4gLQlpZiAoaXJxID4gMCkNCj4g
LQkJZ290byBvdXQ7DQo+IC0NCj4gLQlpZiAoIWlycSkNCj4gLQkJaXJxID0gLUVJTlZBTDsNCj4g
IA0KPiAgb3V0Og0KPiAgCXJldHVybiBpcnE7DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkZXSVcs
IGhlcmUncyB0aGUgYWNrIGFnYWluLg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5O
Z3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
