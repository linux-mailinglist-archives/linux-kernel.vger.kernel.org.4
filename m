Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8DA6D5545
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjDCXuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDCXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:50:18 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0B3A88;
        Mon,  3 Apr 2023 16:50:17 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333LWGh6004829;
        Mon, 3 Apr 2023 16:49:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=mXpmc9XFkC9M4qGgFmEk7Eo/3emz+272MUt3qW/Sw9s=;
 b=GG+rl2WmCLf2FFpTofR0fxiC00+o8xF76NMX8/aj6I50TyFDGFqGQbkn0sXEjq4AzLjZ
 3lc/59ryF7MWUwcaT0WpAOt754DKb2ffLVdiOrQaw3BtC8folkvDZsFTzvx2sILsqSvK
 HiuDcs6R3EUb1hDWjEpt0vNLG8BvW+jEsBy2l7Qt0Gmn8zNNe/5G6Gl/Ud6vBEdgoSCA
 c4PfAvjzGBWnZineADOpU5/rZIfpS+6oTIYBya7UXhpHcJiJnaz+h/JS5j/NfYp8kysb
 GU+fl2jvWs3M2L35NF7xO2mOBkoSQhts+lQlRYsycm++HuwM5Pb0tvX4+WUhK6z1BInW uw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhxbk20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 16:49:54 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48AAFC04C2;
        Mon,  3 Apr 2023 23:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680565793; bh=mXpmc9XFkC9M4qGgFmEk7Eo/3emz+272MUt3qW/Sw9s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RLfzEYWNv9vr4t4WqPZxb++1K+2yLdgb/y4lyYocnv1RdI5bdnFWmE9vjZekXJCwg
         +jH6s6syzWN/zCBy+f89t/ImvHxEmIhxg+8plHi6dLatR9eDg3d2VozhsK/89Jj5A4
         DmtFWSGjNSt55IzNmWyOhO3AaukxWxsHObcpYGkik+nN+JklEaZ/z08ftKDy2de4Ff
         eMnJDoS0C+J9rDy0qs5TDg9TeaTEs42nvclFW8sXxyIdefTqesFMhza6mcOFS2lEgJ
         s18vtnc4QmLykIvvHf+goiYH/QHV/aekH2n6nzTR/TalU3TKAwNhsW6pdAPYcgv4MK
         WFJmp7OWHkmiw==
Received: from o365relayqa-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 270D4A0062;
        Mon,  3 Apr 2023 23:49:49 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=POhaQPI3;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id 70241220887;
        Mon,  3 Apr 2023 23:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSIBgeBkjNS8PMIHIohbCMEESeVWr346p7hDxY/4eJrPriFODfVuDlVvN/ihqofnmRo1dF5Ih/QO0t1GUXj4KormN7orxePTrjLDKNU/0bdKWMtWQKxLTjNBEDMTQ9tZHP+0uipYCgFCrcRwA+v9KLSZ71NWR+MD6pvc2RPpE5lyaqimsqmsvIm/YYlvNIr8/knPHMGZsVm307Zg1/q3yrxgVSiXF9NCp6xCwzM8Yn6OTWpG34Ep3V5WQL/88yRiVsfIbExTYkHDrj+Lh61z29QnoT08jthxcB/3/mefgUUUD6nyGimS1KqLtUVEFiudLnop+6+NG1cn2tnPzcZD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXpmc9XFkC9M4qGgFmEk7Eo/3emz+272MUt3qW/Sw9s=;
 b=BQnWmSinIExqDNAjelIY+R1Qdlo98QYoDB8VjMwDVTzi4KCGczhD6SfcuiYu5bfT++7mcCLS6HG+mnSmMUH4QczyV5QSLtM5RyCIilk+5Vb4tsZkcYH5SuVL4Sv0XEDCL3S2zW3QG62rEkhf2at2n00dH/Mt9NGakzq3ey/XHbjUjlsl9lu7SueOIOiVx+Hei1FIJ2WI8KS7E6j0OVY7+AWbCqMgTPikczntFMLYoAoL8epBijj9cYpIuupVJladpB/nKD53bKZsZpNqI4o3N32iYxTIL1JY107DnTPl4szQFF3GnqlQPFRqFcOC99RSKzTpn03AQYyC4gegHNZ9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXpmc9XFkC9M4qGgFmEk7Eo/3emz+272MUt3qW/Sw9s=;
 b=POhaQPI3nZg1XbPUeMk5vs7ccodR/HsueCuUNf+7hnPWHwb3mmRhOOmSQHYhBkw+DbppmaUyggaYaxSaTXs+GADPe+qZjh7cVJgc+NlbGPg/GqxZst77Cl/ByyHDBgvxXj4f4XloLBCD4tu90/1tdyukaDPW1PhpbLwM9XesMkY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 23:49:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 23:49:44 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUAgAB5QYCAAUhdgIABGcUAgAa8LoA=
Date:   Mon, 3 Apr 2023 23:49:44 +0000
Message-ID: <20230403234937.sotn3pznu4winlkw@synopsys.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
 <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
 <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
 <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
In-Reply-To: <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB8127:EE_
x-ms-office365-filtering-correlation-id: 398b1c33-20ce-42a1-7f6a-08db349e199e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3WfFuSkKvzLAA0g+9MoPCi2fn6bw3f+fmXUuLXDsCWPMNG2GjnIS3eLVrWQs1Wfp5UF4YwPt5a1VchQYbgHDom2S+MD+3tBaDF7r5QwMGfZBupCjfZspCxa8C5imqREZukMjif02I3uuANrDkwzhExEYi+cmyq3JWUMdplVB2OUDqbb1+fqgs4umzMV5z9Uep6yc/Iduqvip9iU1Rd+1oPCqt7/r2vhcmwDx0xUCiwT78WrSrZgvbVcm3chqLma+a5Ns21+arRg+IoYmnoE1m8lwmIwhcZKraFRvNPAV3MQjA8S0NY4ubbSi6rbjlBTMR7EXVsiydOxvcNIjECjzo6pulFXf0zbAWm6x+p6A1p6Nd2iCyjfzg7eNcCSjm0QyO+PbJqq2aq70kkogiufsxBmve6U++cYmz2W3h9gWPnrWzHAGUlqqTfUh8CfzaFjqA+Tq2mr2KT6kzCBuyJMPrJSKzZY8GMxV1gbc3TIUWBOjPchxALTVYHcBwwqEh1gKMWZi9Y6m6nFDe3hRGM6G6rjVwipqbR5GkAFAVED3Tn+F3TRVrw7waaE8NqSvlC5kzHE7kCLyqtl4VxnV2jsIgHLlkda5nhbwouRE0F39RS0mQiDJSnU2y8yvdrwi02T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(8676002)(66476007)(6916009)(66556008)(478600001)(66446008)(41300700001)(5660300002)(66946007)(54906003)(316002)(8936002)(7416002)(2906002)(186003)(6512007)(6486002)(26005)(1076003)(76116006)(4326008)(6506007)(64756008)(83380400001)(2616005)(53546011)(122000001)(38100700002)(38070700005)(86362001)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K21sNDVnYnBmUTZsUm95SU9xQ3k1QUIyNmsvMENGamJpQ0Q3dk1Za01XRERR?=
 =?utf-8?B?YnBqenFScnVCaUZxMjNCTGFHbm9OYm1adUh6YVJTVkRwS0JzRWdwZ0FYemRV?=
 =?utf-8?B?Qzl2YW1yR004MG9wcEIzZmFqRzZ2bGJ0UWRWSU1keWRndERCSWZjN3gyQU91?=
 =?utf-8?B?SGNjcUIwK2tzRXpFMStJelluclE5TXczeG1EUWZvNWcxYWFvTkdKNkZpMUtl?=
 =?utf-8?B?QVVXNllBM2szSE4rRG5CYkZaZ3pxMTNFTTVFblJxN1lJN1VRQjBGNXZhUkhR?=
 =?utf-8?B?TTRKenNacFd6bXlEL0xzYXlXSDZPMWl1bzJ1dVMzL3h2T3pEa1F3WEFXU0RI?=
 =?utf-8?B?eHVmN1BqT0owUjYvbjQ2MlhaYkREaXVvaFdSQzlaUnlxanhGTXhySHIwN2VI?=
 =?utf-8?B?RkEwUXZIMUpQdlRmNTU1dmVoZEpTS2wwdVhhc21mUkxFU3ZvalIybDNqQUlJ?=
 =?utf-8?B?SVQ4R01hcUlocmdpalp6WTJKQnRrWEVYcWhjRVpJN1JMZWFMbW9yUGx0SENR?=
 =?utf-8?B?RXAyVFpTcUdwOVZ6THZKMEY0TUladGRtRk9TQ2JlaVdCMk5wZm1CQ0k4TE5U?=
 =?utf-8?B?eWxPaGJLYzdac2pZSWdnb2JLbzBudWhnU3hUZkJnb1Uwb2M2NXNqN3grUXJI?=
 =?utf-8?B?S2NPL3hEeGp4ckZ1aTMvQk85K1QweWtOc1dzY202eXViRHZ5UjVReUs1YkpI?=
 =?utf-8?B?WXJwWDdqL0dSTklsNW5jT0FaU3pPcTBlR2JJT25Td3NWWHJ6NUU2LzgvcEtQ?=
 =?utf-8?B?U2FkbytXNXVNazVmODlyTVlDTXNZRGR5S0R1MW1TVGphdHVnSm5YeFZFZGVF?=
 =?utf-8?B?aG1yYitkSmRZdkN1TmEyNW4vaHczbXNYUjhlRjAwRW82MUwwb0VCQ0VsOGk1?=
 =?utf-8?B?TXZjM0VXQ2dWT3JvWjBZTmtUSXBEdnl3eWk4bDZEMHNSMVJwc3hUVHhmTHRH?=
 =?utf-8?B?VXR2dU5DU3BnYzQ5UzBJU0lUK1Nwb0lwSXh1dGZ6VEZPWDdLd1VUaXBRNWZ4?=
 =?utf-8?B?ZndGaUhrWjN1ektNdERIbTk5R0FmdmQzeVdTUHlGeDZyZVRSZ2hZaUxXSmxU?=
 =?utf-8?B?YnZRVkFTUmJDYndjMVR2OC95RXY0Z0ovZHViQzJKQ3p1SGNNNDhBbVVHRmdr?=
 =?utf-8?B?SFMyM08xVHZncStDMVJ6VkZLV2tIcGlKS1JxaHdmQVZOV1pkeFVwYVhqSHhL?=
 =?utf-8?B?UWNQZk8wSk5UUG15am9HbXhlbHFuNVo3RUY5cXBueGYvQUllWUIzYXA3Wi9u?=
 =?utf-8?B?dTYraGxxN096Mjc1QjFoUHFyZWVaWkNaem0rMno2S0MwTzkzUENBYjAyd2pZ?=
 =?utf-8?B?a05xbmV1K1NtNHJOdzhSN1FLdktjMW1hTWppTmh4WjVCcVExTHYyUi9NKytV?=
 =?utf-8?B?VXB3cDJCbTI2RE01YWNjT0JydkhMWFgxWjlnOWRTQmRKbytSYVJ1ZjJyTUds?=
 =?utf-8?B?ajl1MUtZN0IxQWFQb3RCcmNSSHUvblpSUnplTXhVVGlHZjIvWkE2WGtHTDA3?=
 =?utf-8?B?RTg1cyswNEJaR0RrNVdXc1ZKZExpNlpvU1BRUGFCY0tySW9MNVd0M1VGeE0w?=
 =?utf-8?B?dWlFMFhrRnByV3dIdGp4SytKZExab2FKS2ROUVlzeTRQMEp5b0tJcklMeVFx?=
 =?utf-8?B?ZWhESCtUQnBRbUlZN01rK1l5a1FuL0w1KzVpRExXYnFEbFdEMEtHUTNkaTFU?=
 =?utf-8?B?aU5SU1hiUXhxR3RyL0h5d2ZiTE5xTSttVUtKbC9pN3dncXRTTDl0bHBERnlr?=
 =?utf-8?B?czlpZzVrbEVSNGRYZ0x6NUJ3TFBLR2JmQ2RKa2tBMW5pTTFJZEVvZUlJY0Z4?=
 =?utf-8?B?c1pYdEJrYi9WNnJZUTRiUjB6S05wMFFWbWJvOUZValZxVk1ZR0RRZmRQOFVY?=
 =?utf-8?B?dENzb2k5Tks4L0pBWWh1bVAyNFE3aXpXK1ZGczZYcFp6YzNPQThQampyQVBz?=
 =?utf-8?B?YkVuRHFTVXI3dGQwWGh1dWl1akN4OGhNbUxaODBNTGhQTkZLdmxuWk1TSjV5?=
 =?utf-8?B?V0Z3ejlPbWpDWThHbUl6emZkajdKV2R5QlU4NXZJSE5saW9UdDJBem9PUUx2?=
 =?utf-8?B?UUl4R1FRcHJzb0dNUUZndmNDbDJFQmFYZm5wL3k5T1BqUjhTOXBVMmoyZjZL?=
 =?utf-8?Q?AP8zur5K/HoMct0ZIcmrFpiHc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67CE7E70221D2499BE96D1FF7F1029E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Rjd1T0x2NU5SZ2V3VUdHMm0ra1hsSE9kaExqRzRVaG90d0owcFVJK0djTDVo?=
 =?utf-8?B?RXlWZk5HazF5UDFMUUJPb1I1Tnp0WVZER1FQSWNQK0VmbXFLTHJhQ3FpZTVF?=
 =?utf-8?B?K3p0a1pHY2VDcnZRRE9kQ2svbTBhVDdTQVRxV1M4b0ozWXlWOFVKY3JVWjIv?=
 =?utf-8?B?Y1B4bm1aclQxOWdCcUd1M0J2Y0tjaXd6ZGtOZ3VOZjJhU25BM2ltMmEzYWVF?=
 =?utf-8?B?RS81MDl6MStZNTNIWWRkVHVJNEZtTk9TOS9vM0NpV2V3ODNJRjVQdExXRDhC?=
 =?utf-8?B?dUtrZ3FqajZiVTZCNkFMN1pjOFliNG8wdzlZbzZ3Zmw1aFFUUUM1clBWZjFn?=
 =?utf-8?B?RzBYK1orSVhSUWJFTU5hVHlRNzhIaHN0d3FRZDNRcFJBaE93Rk80SHEyNnBH?=
 =?utf-8?B?VW5BekpHVEZlR0Z3aG5HSlBOREM1UHM4RHl6eDJLU1VMZXZadkRqRjJ2eWM4?=
 =?utf-8?B?NE1ZeGxlQlgrTmFDTFhOY3JRekRJUEpwWDlsWnZPTDQ0RzJ6Qk0rZ3B6MS9I?=
 =?utf-8?B?dTJMWUpGNVRwTnlldml2WVNYMHR6TG84SGRlelVtcXRCSlp2ckdFN3p5M2RK?=
 =?utf-8?B?T3piZjRiempnTHgra1o4L2F6Z1VyZmZISVVxQ3MrbXYzKzIrK3NheXJsdGV3?=
 =?utf-8?B?dlJ5Sk9rOC82RWJBVkEwbXk0Uy8yTFJ6Z2c5eTZDZm1PS25sRVZmRll4Ui9U?=
 =?utf-8?B?RmZRSFpQVXBITFRqaFNPUUxzUGVVOUFvSklYeVRXbURtVGhKWGdjSGJKZmN2?=
 =?utf-8?B?Y0lsMzdyZDNkR3RJTmtvZWJGMXFxY1NzNzByc3VoUEptUi9kcFNBTXRRRjRP?=
 =?utf-8?B?aDVwVHFUeXlWSkxSYlBDbXRnV1BrVzhzaFV3aWNvYWI1UDhvNmJkS3B0QzQ0?=
 =?utf-8?B?TXZSSDRIdmZOQm5WdDRkUkVwc3crQzBDZGVpb2EvKzJhS3hnZVZSZ1pmakk4?=
 =?utf-8?B?TW1jQ2l6UlNQdTVFU2lZNjd6TjNvRE1zNFBCWkdBcEFGd2psR1RlOFZtTXEw?=
 =?utf-8?B?azk2QjVxZGZha2VUcDRsN0RBSDdjUFV4SWhCVGs1ZkQxVkg1NEFQdTdNdSs4?=
 =?utf-8?B?MjVpZCtVMktVODZHSGxjNEJITFM5SG1FelBZK1luak9ZYjM0eCtGQnlHK2wz?=
 =?utf-8?B?RURBa2tiU3hlUTdpZkVrVnhTaUFtMFJYRUtsN09OL202cEJPcVFIQVZXTlh0?=
 =?utf-8?B?Uktva284NFBLczk0YURlZGhKZXFHODU2bXlUaldxb3FGWUdFdjYrN2hEaDFB?=
 =?utf-8?B?L09VUFlXSXV5T0tjRW9yN0RhS2JiWVhCQ1ZFUlNSNkVnSWpFZXZYQ1BlczUy?=
 =?utf-8?B?anVqL09aWEtSdm5DK3dLKzNuaGExUUJlbDNHN1JLUTg5M0JuSThWc20zYjF6?=
 =?utf-8?Q?f9APcXKR4f+OXXGu1D9i2/lrynh+CI/U=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398b1c33-20ce-42a1-7f6a-08db349e199e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 23:49:44.2287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuvhY+L8NM4JxxoZyKmpS5eIFBeEmXJy0NtQfxik45irhY+HEW19M9Otr1C0bTkLGc+KzfgwUBazz/TaY4cwFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
X-Proofpoint-GUID: LN990LWdBLJQq62Ad4yupC-edw9pAoqN
X-Proofpoint-ORIG-GUID: LN990LWdBLJQq62Ad4yupC-edw9pAoqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030189
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMzAsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMy8zMC8yMDIzIDU6NDAgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIE1hciAyOSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBPbiAzLzI5LzIwMjMgMjo1MCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgTWFyIDI4LCAyMDIzLCBLcmlz
aG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gPiA+IElmIHRoZSBjb3JlIHNvZnQgcmVzZXQgdGlt
ZW91dCBoYXBwZW5zLCBhdm9pZCBzZXR0aW5nIHVwIGV2ZW50DQo+ID4gPiA+ID4gYnVmZmVycyBh
bmQgc3RhcnRpbmcgZ2FkZ2V0IGFzIHRoZSB3cml0ZXMgdG8gdGhlc2UgcmVnaXN0ZXJzDQo+ID4g
PiA+ID4gbWF5IG5vdCByZWZsZWN0IHdoZW4gaW4gcmVzZXQgYW5kIHNldHRpbmcgdGhlIHJ1biBz
dG9wIGJpdA0KPiA+ID4gPiA+IGNhbiBsZWFkIHRoZSBjb250cm9sbGVyIHRvIGFjY2VzcyB3cm9u
ZyBldmVudCBidWZmZXIgYWRkcmVzcw0KPiA+ID4gPiA+IHJlc3VsdGluZyBpbiBhIGNyYXNoLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1
aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICAgZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gPiA+ID4gPiAgICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+ID4gPiA+ID4gaW5kZXggM2M2M2ZhOTdhNjgwLi5mMDQ3MjgwMWQ5YTUg
MTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiBAQCAtMjYyMCwx
MyArMjYyMCwxNiBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3B1bGx1cChzdHJ1Y3QgdXNiX2dh
ZGdldCAqZywgaW50IGlzX29uKQ0KPiA+ID4gPiA+ICAgIAkJICogZGV2aWNlLWluaXRpYXRlZCBk
aXNjb25uZWN0IHJlcXVpcmVzIGEgY29yZSBzb2Z0IHJlc2V0DQo+ID4gPiA+ID4gICAgCQkgKiAo
RENUTC5DU2Z0UnN0KSBiZWZvcmUgZW5hYmxpbmcgdGhlIHJ1bi9zdG9wIGJpdC4NCj4gPiA+ID4g
PiAgICAJCSAqLw0KPiA+ID4gPiA+IC0JCWR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4g
PiA+ID4gKwkJcmV0ID0gZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiA+ID4gPiArCQlp
ZiAocmV0KQ0KPiA+ID4gPiA+ICsJCQlnb3RvIGRvbmU7DQo+ID4gPiA+ID4gICAgCQlkd2MzX2V2
ZW50X2J1ZmZlcnNfc2V0dXAoZHdjKTsNCj4gPiA+ID4gPiAgICAJCV9fZHdjM19nYWRnZXRfc3Rh
cnQoZHdjKTsNCj4gPiA+ID4gPiAgICAJCXJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3Yywg
dHJ1ZSwgZmFsc2UpOw0KPiA+ID4gPiA+ICAgIAl9DQo+ID4gPiA+ID4gK2RvbmU6DQo+ID4gPiA+
ID4gICAgCXBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gPiA+ID4gPiAgICAJcmV0dXJuIHJl
dDsNCj4gPiA+ID4gPiAtLSANCj4gPiA+ID4gPiAyLjQwLjANCj4gPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IEkgdGhpbmsgdGhlcmUncyBvbmUgbW9yZSBwbGFjZSB0aGF0IG1heSBuZWVkcyB0
aGlzIGNoZWNrLiBDYW4geW91IGFsc28NCj4gPiA+ID4gYWRkIHRoaXMgY2hlY2sgaW4gX19kd2Mz
X3NldF9tb2RlKCk/DQo+ID4gPiANCj4gPiA+IEhpIFRoaW5oLA0KPiA+ID4gDQo+ID4gPiAgICBT
dXJlLiBXaWxsIGRvIGl0Lg0KPiA+ID4gV2lsbCB0aGUgYmVsb3cgYmUgZ29vZCBlbm91Z2ggPyBP
ciB3b3VsZCBpdCBiZSBnb29kIHRvIGFkZCBhbiBlcnJvci93YXJuIGxvZw0KPiA+ID4gdGhlcmU+
DQo+ID4gDQo+ID4gVGhlcmUncyBhbHJlYWR5IGEgd2FybmluZyBtZXNzYWdlIGluIGR3YzNfY29y
ZV9zb2Z0X3Jlc2V0KCkgaWYgaXQgZmFpbHMuDQo+ID4gDQo+ID4gPiANCj4gPiA+IGtyaXNrdXJh
QGh1LWtyaXNrdXJhLWh5ZDovbG9jYWwvbW50L3dvcmtzcGFjZS9rcmlzaG5hL3NrYWxlczIvc2th
bGVzL2tlcm5lbCQNCj4gPiA+IGdpdCBkaWZmIGRyaXZlcnMvdXNiLw0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
PiA+IGluZGV4IDQ3NmI2MzYxODUxMS4uOGQxZDIxM2QxZGNkIDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ID4gPiBAQCAtMjEwLDcgKzIxMCw5IEBAIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9k
ZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPiAgICAgICAgICAgICAgICAgIH0NCj4g
PiA+ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiAgICAgICAgICBjYXNlIERXQzNfR0NU
TF9QUlRDQVBfREVWSUNFOg0KPiA+ID4gLSAgICAgICAgICAgICAgIGR3YzNfY29yZV9zb2Z0X3Jl
c2V0KGR3Yyk7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0gZHdjM19jb3JlX3NvZnRfcmVz
ZXQoZHdjKTsNCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiANCj4gPiA+ICAgICAgICAgICAgICAgICAg
ZHdjM19ldmVudF9idWZmZXJzX3NldHVwKGR3Yyk7DQo+ID4gPiANCj4gPiANCj4gPiBJZiBzb2Z0
LXJlc2V0IGZhaWxlZCwgdGhlIGNvbnRyb2xsZXIgaXMgaW4gYSBiYWQgc3RhdGUuIFdlIHNob3Vs
ZCBub3QNCj4gPiBwZXJmb3JtIGFueSBmdXJ0aGVyIG9wZXJhdGlvbiB1bnRpbCB0aGUgbmV4dCBo
YXJkIHJlc2V0LiBXZSBzaG91bGQgZmxhZw0KPiA+IHRoZSBjb250cm9sbGVyIGFzIGRlYWQuIEkg
ZG9uJ3QgdGhpbmsgd2UgaGF2ZSB0aGUgZXF1aXZhbGVudCBvZiB0aGUNCj4gPiBob3N0J3MgSENE
X0ZMQUdfREVBRC4gSXQgbWF5IHJlcXVpcmUgc29tZSB3b3JrIGluIHRoZSBVREMgY29yZS4gUGVy
aGFwcw0KPiA+IHdlIGNhbiBmbGFnIHdpdGhpbiBkd2MzIGZvciBub3cgYW5kIHByZXZlbnQgYW55
IGZ1cnRoZXIgb3BlcmF0aW9uIGZvciBhDQo+ID4gc2ltcGxlciBmaXguDQo+ID4gDQo+IEhpIFRo
aW5oLA0KPiANCj4gIEFyZSB5b3UgcmVmZXJyaW5nIHRoYXQgaWYgX19kd2MzX3NldF9tb2RlIGZh
aWxlZCB3aXRoIGNvcmUgc29mdCByZXNldA0KPiB0aW1pbmcgb3V0LCB0aGUgY2FsbGVyIGkuZS4s
IGR3YzNfc2V0X21vZGUgd2hvIHF1ZXVlcyB0aGUgd29yayBuZWVkIHRvIGtub3cNCj4gdGhhdCB0
aGUgb3BlcmF0aW9uIGFjdHVhbGx5IGZhaWxlZC4gU28gd2UgY2FuIGFkZCBhIGZsYWcgdG8gaW5k
aWNhdGUgdGhhdA0KPiBnYWRnZXQgaXMgZGVhZCBhbmQgdGhlIGNhbGxlciBvZiBkd2MzX3NldF9t
b2RlIGNhbiBjaGVjayB0aGUgZmxhZyB0byBzZWUgaWYNCj4gdGhlIG9wZXJhdGlvbiBpcyBzdWNj
ZXNzZnVsIG9yIG5vdC4NCj4gDQo+IE9yIGFtIEkgbWlzdW5kZXJzdGFuZGluZyB5b3VyIGNvbW1l
bnQgPw0KPiANCg0KTm90IGp1c3QgaW4gX19kd2MzX3NldF9tb2RlKCkuIEkgbWVhbiBhbnkgdGlt
ZSBkd2MzX2NvcmVfc29mdF9yZXNldA0KZmFpbHMsIHRoZW4gd2Ugc2V0IHRoaXMgZmxhZy4gU28g
dGhhdCBpdCBjYW4gcHJldmVudCB0aGUgdXNlciBjYWxsaW5nDQphbnkgZ2FkZ2V0IG9wcyBjYXVz
aW5nIG1vcmUgY3Jhc2hlcy9pbnZhbGlkIGJlaGF2aW9yLiBUaGUNCmR3Yy0+c29mdGNvbm5lY3Qg
aXMgYWxyZWFkeSB3cm9uZyBvbiBwdWxsdXAoKSBvbiBmYWlsdXJlLg0KDQpTbyB0aGF0IHdlIGNh
biBoYXZlIGEgY2hlY2sgaW4gZGlmZmVyZW50IGdhZGdldCBvcHMuIEZvciBwdWxsdXAoKToNCg0K
c3RhdGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoKSB7DQoJaWYgKGR3Yy0+dWRjX2lzX2RlYWQp
IHsNCgkJZGV2X2VycihkZXYsICJyZXNldCBtZS4geF94IFxuIik7DQoJCXJldHVybjsNCgl9DQoN
CglhYmMoKTsNCn0NCg0KUGVyaGFwcyB0aGUgZWZmb3J0IGlzIHByb2JhYmx5IHRoZSBzYW1lIGlm
IHdlIGVuaGFuY2UgdGhlIFVEQyBjb3JlIGZvcg0KdGhpcz8gSW4gYW55IGNhc2UsIEknbSBmaW5l
IGVpdGhlciB3YXkuDQoNClRoYW5rcywNClRoaW5o
