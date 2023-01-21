Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C799676285
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjAUAmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjAUAmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:42:09 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9749413;
        Fri, 20 Jan 2023 16:42:07 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KNhiD8011015;
        Fri, 20 Jan 2023 16:21:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=AxQwFSwDbjd4vsYC1ivwUxwaSi3j8i2bk2GDxuDVZUo=;
 b=ru2yWvYU7qNahz/c8ypKWXIMAWyLnxADMmQdrnYRqto+goDZqWfinbziHQ3PhUO32aHD
 NJAOxBQ1ztwxkXldbgvXJE2aakL3m7p6KYsWl+wzwD3z34H/Omi6ORE6J2M29ITP1i0A
 /G71W8/+jwFaNTjaPgSsrufqu5W8sFrS5pM/9EH9h3W0uboQb4EzB2QdwW/tH1om2/9k
 8uJ1eHOE9unQxkJwo+NXSNFahFTZmv7R2dvvTDXOaNo7FmVmMqZ9LF1VbjRYpKh2crlZ
 lFLkcLhxVkLZSwuJDoE+zRKGKa3ONOXsz3C4F2PIL3UQ4zvAkc6cFmW/yd6Veofec9kI RA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3vhba2p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 16:21:16 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C84AF4007B;
        Sat, 21 Jan 2023 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674260476; bh=AxQwFSwDbjd4vsYC1ivwUxwaSi3j8i2bk2GDxuDVZUo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X4jo6RoGkakPxBX/rTJDelbCLkWgYPXur+62un9n6FnWca3qah99BXK35FX+ihZJx
         XBg3y2ezq1hOjVrFBMcy7hRp6+01FwLNudk1zk/SZnOYT6Uza92rPGPO8fnTPEUkZu
         dmiV/TKphzz9gjU9W3eOmb+ye87rr0oj8D30uTku4uXWK5TVdwoiOeDaSNuwTAtcVZ
         RrcLO8ix/8CuQSHov/7LbOJIbQJ2xuLBO5MwS5LZs5ylUot0s/OM7m55BZrYFjfZpC
         em4MiZkBpakI9tPVVvMEYt1gH6rcYsw8pC+zaFwruJ3AxeB+Gy1s42hVwTPlHdr7Fi
         o+tTxjj5R3o/Q==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 35960A005C;
        Sat, 21 Jan 2023 00:21:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 30C69800DF;
        Sat, 21 Jan 2023 00:21:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FJ5WP8T3";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB2wjdr2mZ16D/vxlgWSrSnPeKaMRe0hKa2NCaTQu1u3nYVVudM0oO289XLpaetiZNeZgR2wa4fJJOYh5yKmM8+sLSfiTQuGNiC0wS48UaUj6hT+Y/XHzkJ0+WwyTDgUt+YILMMcnhaolIx7wXKogH1DiOmvCbhDPD8rGWCHL2FMi+sts9fjJIsqrVnTIT7K7fEZJNQeU29Y7+yYWa/Ycmhl/7N0oQX6vGX9OWV5Hz+znHL5cRgPKon6AeOrZ9cqMlMsw1VLoAXfnizulGy/3HXZlRttXXRlaBvbcWX05IRAQgqQWaqHhAZLFLRVSBrefvvix9NW9uhxvuFt4uuUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxQwFSwDbjd4vsYC1ivwUxwaSi3j8i2bk2GDxuDVZUo=;
 b=dfPoRyITMhz5lzDrDmTkaaN4t1S8RBRW35Y+A64lW6w8MZn1h1eP/T2c58WrLRuLqacIeoKR5oh4vrYL+zNdGWioiVgDPrhysE7bme3sze4z40OqMYlZAy6g1ikGnmdHXpXZKUx5NgWDUpIcsXtTEaVGU/Fae9qmLmQ9iEGcpovF8sXsEOxj8H6Q3xWafE00STe78Jz9dSJNEowUIWony4GdAUOsgR9enJ+CB+0t81HUozi2D55sMhmA5Nj7/1L6zXFHZQ18pi3UAOR6kDA6WBGsljwKJhzPlfy9hCjfEjl+tFnEJPDHqr+fE9Q0Dh6n3ZQHeLokjcBQ2fvYAsPKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxQwFSwDbjd4vsYC1ivwUxwaSi3j8i2bk2GDxuDVZUo=;
 b=FJ5WP8T38oBEEZg5kvffeMOfNuSzKGFg2mQ4f2VTHqlTG2knfsxxHIVRwj6ApPBXA6GEWUn/0nVAj/7jBGlbsKdEm3859sPbIa+n8gQqcl+ByzrXFhOmvpYbJUiQ21ZvyQ2FqCsLRg8craUb/6pkqKYHaYp49DQ8zx7XsQ2Sm/s=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sat, 21 Jan
 2023 00:21:11 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 00:21:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6AgAF5HgCAABEigIABfykAgAAEBYA=
Date:   Sat, 21 Jan 2023 00:21:10 +0000
Message-ID: <20230121002059.mpiqavemelnntxd7@synopsys.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
In-Reply-To: <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|MW4PR12MB7165:EE_
x-ms-office365-filtering-correlation-id: 8b120dbb-7199-46e1-23ad-08dafb4565a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9xaAqGaYHAFw7YK7T/ib7Lv87wsy5mvIcV7TFWiYRt7/dilq5uXJK4An1zsRAiwIv6OIdnviGIQ7Zt15FZfpjMr6VzkgBPDD0zmsVjceIB+8+EC/5Ssx7FusuUwDMYr2jM7KpQYT2+qrohGlCPJUBDDhmvUC8ZmoI2+RHihKbIK+xn3MOy+kkAaDwWM02tNt1T7npFMq6NVlBpRYfVQkQ7l/+IPbpCqfazx4RJyJOmVTVS86O35OOyTDqlliBWPh/LsEXIx+DsZX3igV8eZrZUA9wlZ5tu66d9nckcpnnyGGtU+VPX3cEYr+9n1kHFnQntd5EyVMYE5rrOiNiZFklx/9g2xNv2GL+/CANcRv5SpHgudBTBrePVyY9vtiZkcAlUgZrHdeqX36nMUlUJaXz1Kk+w5thDFTdUsJ41iq7oxCvOkgr9NXcClllG7L0TohWg45f5NXhJS9oXkS/fO6ZM7pdBnxINFqNjFL8YovE4qvIg0lWljctMN/8btILv2lairy71E38p4WKnrZfuMAAcfB6tauwJ18ru5hiJAuWxcEha6IBU+JRanB9VTX2QTVNt4vhJWLQuiR6t39iM/u9CA9U/+sJiZc0hmj+qxYKIOKmCoZReY5emiMDNg1VlmpFWdkRP6DhSz9hsKvJeZ4A8hAAc3rhefYVJK97HKKUryPDDT1Megx7IYeqLvWu+opmoZn1GTIHUj7DAMOex4OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(8936002)(316002)(71200400001)(5660300002)(122000001)(86362001)(6486002)(36756003)(6506007)(478600001)(53546011)(2906002)(2616005)(6512007)(54906003)(38070700005)(1076003)(66446008)(6916009)(4326008)(8676002)(66556008)(64756008)(186003)(76116006)(26005)(66476007)(66946007)(91956017)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0pRcXZ0R0Zhd1pOY1c1d2hTVW01U3BYNFNsLzZISm5YaENkNDZPaUJVRXFn?=
 =?utf-8?B?dlpaSVRJTXdSVHIrTXhlRHlBc2NrcTVJM3J5L2VZYnlkRzBqMGRIS0hDQVFW?=
 =?utf-8?B?S3Q0U2ZQWlZ3QUdyekI5YlQwc1VRM21ROWhaVmRKTUpTMllPRmVqTHRBRXNW?=
 =?utf-8?B?RDJkeC9SN3lnN2R4ekRncGI5WnZ6ZU1LMFg5WEsweFp1blR0TlR3aU5VQnFv?=
 =?utf-8?B?SGVJdnhCWlVuc1pmVklYeURXWkxFZ2RuNkk2MDF5cWJWM3VqbndBM2pFZkFp?=
 =?utf-8?B?RDhudFNHbTY0UDZnV1NoZTVFcURVa3Y5Z1R4UGZqaDVzTG80em1xR3ZGZlk0?=
 =?utf-8?B?aHJyUUE3VncvTTBTbDR1OHpVMmJVdkdMWk44bTNOVHlSU0tLc2V3Y0ZWWmR2?=
 =?utf-8?B?ejU4YzJFd0FKZ01SYkF1N3p0S2s0ZURhMVd2bmM0Y0ZtMk53bm1ROVdoRG9O?=
 =?utf-8?B?OHNkSmMreUhFS2o2VDBURDh2dVFsZ1dDZTFXWnl6TlR3c2NMMGhqeDZxYlBl?=
 =?utf-8?B?WTAyUzQxcnd0VkRSWDhUaEV3cG5iSnZ1RlVQWitVaHdueVJtUDhocDNSSVQ2?=
 =?utf-8?B?OFpCSS9CNHB0ZWlrd2ZiTk4ybnZmMGxPakdSSk5udThRLzhGaTFhZ0kzcWgz?=
 =?utf-8?B?QUpmYWtxb2krbmw2YnB0NFppRitmUmhKOXBNRzZOWnhjY0dMUUxZc0ZGYTdh?=
 =?utf-8?B?Qml4MzducW1aSDhDT0ZwRTJRQzk1L1BUUHd1eXR2NVRkNEVNT2YxTGVMeEtW?=
 =?utf-8?B?c0ZjSDl1OE5GcWlUWEVqcUw1elo0Z1RkM3FjdTFKc0o0TFZud0xXWkFlN2FT?=
 =?utf-8?B?K3FoZlEreXIrM29ydHVmaEphUS90VkFqdTFNM3VLUDJud3FJVDZuVnIzcTRl?=
 =?utf-8?B?K0tzUzA0NEdUcTNCbFd1SUhnazJaTUE3a3ZJSklrMHFnWnNhRG1hV0t2eHc4?=
 =?utf-8?B?akl6RkVvT0N5MjM1cTB4YVZ0UWN5eGh3Q3I0ZERQZWMwZENxclRBS2VtdW1G?=
 =?utf-8?B?emFUbUxLY0dQVFoxOTlCOFkrTVo4TUJqK3RzS2RLSGR0Mm4rem1xTzNyZ3l6?=
 =?utf-8?B?WEgxMEZOV0NhOVRJSzBobUZlcnJaM2ZSVWZUbm5DOExmQVRyRXk1UlF3bkpD?=
 =?utf-8?B?TjlvRkROMEVCYjZFMkRUVkJiZ2xpWStkd3JCR0h0Mjl0aWFhMzZvMjFPajJC?=
 =?utf-8?B?SGpacGtOMG5XOFNIcG0rcktJbHB0NkR2YTZySlE5VmpKY3A4RnV6a2tWSXcy?=
 =?utf-8?B?ODNrTS9IM3J3c0tSK2VkTlk0TlhXM0NyNUNyZGE4bkRnWVRZS1I1U2tqSDkz?=
 =?utf-8?B?Rnl5aFJzUnVkeDg3NHlPb0RhSFVJbkRwNTdxT2JMZHNoT1JSOTFBTDJZWFhJ?=
 =?utf-8?B?clljam5WdmpwZVV6REN2Q2lHbXZlWDYya0xuYkUrbFBtRHUzYVVIblVIZ2JO?=
 =?utf-8?B?WVdIL1ZUQ0NFL2pwMVJoSjRvbUVlWXRmcUtxVGltVUdTblNvMm5jRFo3OEMx?=
 =?utf-8?B?cVFGemhoZGdiYzZtZ0JNdHU2c05kOEJUdTU1dHpOV1d3QU41VXpMd21KVDkv?=
 =?utf-8?B?RFZXNmFNQU1lZnVIWWdkYmxCanJabHBwQk16V0lrVEdleXlHV2p0cndqZzY2?=
 =?utf-8?B?NTlpZkN5ayt2WGlaQk1XOURBcmRoOHU3N2Y3YitwVm1VWnVaUlRpMm5BMkNu?=
 =?utf-8?B?TTB1ZitEQUFaVVVJMGZydTNBdnU0MVpoeXFSZVR1VmFmR0VYSjJrMWtwK2Jh?=
 =?utf-8?B?UklkYkF5a0Y0QU8vUW1qbm95bzA4RWFLbVFoREl1VDRSUldXSSt6NDIrQjJU?=
 =?utf-8?B?MDdpZ240VzJTS0dPUVBndDBUWlM1OXRkYjlPcDdWcDlzSFRuaWpadGw0TjMr?=
 =?utf-8?B?ZFZhbkVIQ0xFNmQwV2JRTDIzRmZ3K1Z1aVUzdnRuT0FvK21GS2ozdDF5QTl4?=
 =?utf-8?B?SkdaeHA5MmZ5WENVRTFTZDBUOU9MOUNDRmJhMlhtNlZYWS8zREZVTCt1MWpB?=
 =?utf-8?B?MFZXMmxLeG9iaTdjUURXVkF6ZlByMFYyRFI5Q3QwbDUzQ2d3M01SMWhFandX?=
 =?utf-8?B?Uk1Ua213OUhuaTdYdEswUXlIMWw5SzhPbHIxQ2VQd3NIMEJ4ampyczQzVURS?=
 =?utf-8?B?MHMydHhBbEZYUnE1clA1OVFVT2JPaTdhOERYMWZlSHVwYXBjZGs3MmJjRG5j?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3E81C287E4964FAE10796D52A7A0CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k5h+TiTsxnkHubTIYeS1juCu3AwCg1yJyWHjMDw6w17u2bTtLeBe1+eI4uHHNr2FO20zuuMLyUbgP5gXnJ3SrkYltg/j5atzYiIL+rk7Fwf9IadACo75PMhm+xl7keqBmsHswnJ+iiNE29W5hfwNzo/LpHPfSyCuDnJZ6wPA5NPty5shWlROoGgJlJUTWfrV1ysI1fxlem8E1e4/7lU6YKp6coatEHXWggG1/ismSTgZ1msRK7NDrkxb+YJF6DSHPpMYnT0pOmfdr8f4IsZaQGuT1H9Jp8o9GeuQIpOVKmjRhRenPMZWD0BD6suXDIj1LXiBmco9IHsjIS7rOqEA1P5Q6oShJBGeSq+E/PGKImeCD8Oouxu3VxRpYqUFf/jiZAFRVRoD1+K7ow+Q4+5Rkub8IyaCe9uuYCTKkQOG74ZSqkPJU9SMN7XmM9eM9ETuuRlLurE2YnzB+by47WpshLjszUQpXIhFKJLoNDnEuxzBZLcjSteJerZ7GI4myoZqyYE3244djkeRWHVNuviHI8U/N8g4GONz1WuXdd49pyF1hC0n6DCzoDnXrPdPfsAU3QYuGr+ikpbq82IaHXboYTvuRcOinkRxh/jaPghAw2tYhctA9BRjlgEdWOKIQGD4SH9OAKLw+to0bRxkzboEI+rmGLDgvtOhIc7FXXPUdfzM8PcPHGDb09REX7N8Dw4h6qb5HCAhfOVOLEwePZkAf6OLEhVNg7yB3yDcHRZsVbTwuLPaQygrxaILkisZWnKWwuEfaoC4t8SLlXtnRG7C3yPNf/H9I9Wr69FzD83lTge1CFuWuRSVnCtjc9JrGbPoSB7k099NndNLiyG0Y1bl4La1mnresOUjFGhnz+CzWe9z7tF9GtMzRPNF0uQu2hstccJRlrwWBXNQ8a4D7cfYHmfzcJQgB62eD+zl6h3Z744=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b120dbb-7199-46e1-23ad-08dafb4565a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 00:21:10.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iyEepWafZ4nXXUXAE16X5OBbx5u/DdJE9FfGBUkW4WpCKRksBWV/WRwO/ZVh4riNQBBnMqE7unHNWtMrfXRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
X-Proofpoint-ORIG-GUID: c95p-M8jEV-aWyOb8q5BSQrXSW0jNNPw
X-Proofpoint-GUID: c95p-M8jEV-aWyOb8q5BSQrXSW0jNNPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301210001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMjAsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAx
LzE5LzIwMjMgNToxNSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRodSwgSmFuIDE5
LCAyMDIzLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gMS8x
OC8yMDIzIDU6NDQgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCBKYW4g
MTcsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+ID4gQWRkIGEgZmxhZyB0
byBpbmRpY2F0ZSB3aGV0aGVyIHRoZSBnYWRnZXQgaXMgY2FwYWJsZQ0KPiA+ID4gPiA+IG9mIHNl
bmRpbmcgcmVtb3RlIHdha2V1cCB0byB0aGUgaG9zdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+
DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0
ZS5jIHwgMyArKysNCj4gPiA+ID4gPiAgICBpbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCAgICAg
fCAyICsrDQo+ID4gPiA+ID4gICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBv
c2l0ZS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+ID4gPiA+ID4gaW5kZXgg
NDAzNTYzYy4uYjgzOTYzYSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvY29tcG9zaXRlLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9z
aXRlLmMNCj4gPiA+ID4gPiBAQCAtOTY1LDYgKzk2NSw5IEBAIHN0YXRpYyBpbnQgc2V0X2NvbmZp
ZyhzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYsDQo+ID4gPiA+ID4gICAgCWVsc2UNCj4g
PiA+ID4gPiAgICAJCXVzYl9nYWRnZXRfY2xlYXJfc2VsZnBvd2VyZWQoZ2FkZ2V0KTsNCj4gPiA+
ID4gPiArCWlmIChVU0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJpYnV0ZXMpDQo+ID4g
PiA+ID4gKwkJZ2FkZ2V0LT5yd19jYXBhYmxlID0gMTsNCj4gPiA+ID4gDQo+ID4gPiA+IFNvbWUg
ZGV2aWNlIG1heSBub3Qgc3VwcG9ydCByZW1vdGUgd2FrZXVwLiBnYWRnZXQtPnJ3X2NhcGFibGUg
c2hvdWxkIGJlDQo+ID4gPiA+IHNldCBhbmQgcmVwb3J0ZWQgYnkgdGhlIFVEQy4gTWF5IG5lZWQg
YSBnYWRnZXQgb3BzIHRvIGVuYWJsZSByZW1vdGUNCj4gPiA+ID4gd2FrZXVwIGhlcmUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IFRoaW5oDQo+ID4gPiA+IA0KPiA+ID4gTm90
IGV4YWN0bHkgY2xlYXIgb24gd2hpY2ggcGFyYW1ldGVyIGluIFVEQyBkZWNpZGVzIHdoZXRoZXIg
YSBkZXZpY2UNCj4gPiA+IHN1cHBvcnRzIHJlbW90ZSB3YWtldXAuIEhlcmUgSSBoYXZlIHRoaXMg
ZmxhZyBqdXN0IHRvIGluZGljYXRlIHdoZXRoZXIgdGhlDQo+ID4gPiBjb25uZWN0ZWQgZGV2aWNl
IGlzIHJ3IGNhcGFibGUgYmFzZWQgb24gdGhlIGJtQXR0cmlidXRlcyBwb3B1bGF0ZWQgaW4gdGhl
DQo+ID4gPiBjb25maWcgZGVzY3JpcHRvci4gSWYgdGhlIFVEQyBkb2VzbnQgaGF2ZSBhIGNhbGxi
YWNrIGZvciByZW1vdGUgd2FrZXVwIHdlDQo+ID4gPiBoYXZlIHRoYXQgY2hlY2sgd2hlbiBjYWxs
aW5nIHRoZSBnYWRnZXQgb3AgaW4gdWRjL2NvcmUuYyAoaGF2ZSBhZGRlZCBhDQo+ID4gPiBzaW1p
bGFyIGNoZWNrIGluIHVzYl9mdW5jX3dha2V1cCgpIGFsc28gKS4NCj4gPiANCj4gPiBUaGF0IGZs
YWcgZGVzY3JpYmVzIHRoZSBnYWRnZXQncyBjYXBhYmlsaXR5LCBub3QgdGhlIGRldmljZQ0KPiA+
IGNvbmZpZ3VyYXRpb24uIEhvd2V2ZXIsIGl0J3MgYmVpbmcgdXNlZCBhcyBhIGNvbmZpZ3VyYXRp
b24gZmxhZy4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCj4gPiANCj4gDQo+IFRoYW5r
IHlvdSBmb3IgdGhlIGNsYXJpZmljYXRpb24uIFBsZWFzZSBsZXQgbWUga25vdyBpZiBiZWxvdyBh
cHByb2FjaCB3aGVyZQ0KPiB3ZSBjb25zaWRlciBib3RoIGdhZGdldCdzIGNhcGFiaWxpdHkgYW5k
IGRldmljZSBjb25maWd1cmF0aW9uIGZpbmU/DQo+IA0KPiBpZiAoZ2FkZ2V0LT5vcHMtPndha2V1
cCB8fCBnYWRnZXQtPm9wcy0+ZnVuY193YWtldXApDQo+ICAgIGdhZGdldC0+cndfY2FwYWJsZSA9
IFVTQl9DT05GSUdfQVRUX1dBS0VVUCAmIGMtPmJtQXR0cmlidXRlcyA/IDE6IDA7DQo+IA0KDQpU
aGUgd2F5IGdhZGdldC0+cndfY2FwYWJsZSBpcyBuYW1lZCBhbmQgZGVzY3JpYmVkLCBpdCdzIGEg
Y2FwYWJpbGl0eQ0KZmxhZy4gVGhhdCBpcywgaXRzIHZhbHVlIHNob3VsZG4ndCBjaGFuZ2UgZnJv
bSB0aGUgdXNlciBjb25maWcuIFBlcmhhcHMNCndlIGRvbid0IG5lZWQgdGhhdCBpbiB0aGUgdXNi
X2dhZGdldCwgYW5kIHdlIGNhbiBoYXZlIHNvbWV0aGluZyB0aGF0DQpsb29rcyBsaWtlIHRoaXM6
DQoNCmlmIChnYWRnZXQtPm9wcy0+d2FrZXVwICYmIChjLT5ibUF0dHJpYnV0ZXMgJiBVU0JfQ09O
RklHX0FUVF9XQUtFVVApKQ0KCXVzYl9nYWRnZXRfZW5hYmxlX3JlbW90ZV93YWtldXAoZyk7DQpl
bHNlDQoJdXNiX2dhZGdldF9kaXNhYmxlX3JlbW90ZV93YWtldXAoZyk7DQoNClRoZSBzZXR0aW5n
IG9mIHRoZSByZW1vdGUgd2FrZXVwIGNvbmZpZ3VyYXRpb24gY2FuIGJlIHRyYWNrZWQgaW50ZXJu
YWxseQ0KYnkgdGhlIGR3YzMgZHJpdmVyIGJhc2VkIG9uIHRoZSB1c2JfZ2FkZ2V0X2VuYWJsZV9y
ZW1vdGVfd2FrZXVwIGNhbGwuDQoNClRoYW5rcywNClRoaW5o
