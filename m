Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99D86E5749
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjDRCHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:07:06 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1F19BB;
        Mon, 17 Apr 2023 19:07:04 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HIdEr7002240;
        Mon, 17 Apr 2023 18:47:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=VBOSGdVeWSJEGT1WUBa+PpCxlCbUiskJlpLpZU+XS7Y=;
 b=V7tiTOP2bPHcsrkrrbUuMUxN+3W5V/xAVHTh/vAQ0LbS2S3nRYzs+1ugdw2WUCIab1Ug
 RrKiL4t0bMHN3/ZFjQjqgSGJu/Z5pIko6D06XCYI76gfV/1lS4d2Tc4vRn6azvpLWIvc
 gOmg9x0K8HUkQJOY+Scj9YRLwzK/T0nD0u8bSwlae+NeDEx2NOiYL/NZ4DPp/5zl+dY4
 HnBDb6q7CfV5kRi1QMvnZNxg0SFz98zBueDsn2wzeQ69LcTb+C1DjWA1xuRfLImvALZO
 nTvxPQE7r7pVOqrU5vV8XoFzo4re5H1+N8yYvSQ6rANjuxUy2X4gNoWAnDZbDiq9jlBK nQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pytuvhpa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 18:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681782462; bh=VBOSGdVeWSJEGT1WUBa+PpCxlCbUiskJlpLpZU+XS7Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F86EoVSLU32PMdC6BvZdDid1cGNjcszs3bNdgINuiCusqkambLnBIwjZwWJNuNYl3
         z/q0/5Yp6sb5yD/M2cWC3RmoyDie2ZB1YX7SzaoHgg94nXdUnqprWLaJEmmKjFBEqA
         XxOaQPk1i6DaOlLecgUIclPW0COK97Y1i75phy0MoTr3V7+/1BDpZwK07t2gcMYOJm
         tcVzocNnBPZr4HDoRjeDw4yBi636B5eCGwX6okmkD5Orbi66veFa4CqUWaGEfcRHyV
         BqgCe8upK8Nc2oSBdnv15tgzkvOoVJ+8OC1ANoU4Lt1R/9ZCZ2Uok9UmMEbfAuFUFJ
         0f9sRSbfA+3pQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 473B540A83;
        Tue, 18 Apr 2023 01:47:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EE5F5A0083;
        Tue, 18 Apr 2023 01:47:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=O2xNo+Ds;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C608240A7F;
        Tue, 18 Apr 2023 01:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7zPUTr9kux5CTEDQeEEvCbYLi6QtKXfTR2yWHNSXNrvUQAvuX6ISv0o7EVOMavcAhWiSjPSsRfxqND040k1/XWYTt7ik26PX1VVlrCipw6czAX54qf9+0o0MQhCgC7i1wZhZjuzs8urme/BEdjqKKHaEx550xPqvny9BnanYwDn8X8qa15FpkJtQR7fTRlZM2Fg9enxhEXofyqK2KrT587tjWqSpvt0L5sIa7A2C2jvcucuzPlUGGSwKVQSeN1r0n8/Pdogd0yYgGg7XjAUJvXaVZLxbYJPDmeygB8Xm0D3DhVM3nzjxR5xKBivSvCmSkTc3wVCEO+QIEDoeKtQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBOSGdVeWSJEGT1WUBa+PpCxlCbUiskJlpLpZU+XS7Y=;
 b=D1q+jBQ8M4/4TUpvT/6h/BW9XfLI17B/Xeg0jL0ck4igTjs5AmHOdu1CTm7pGf7+9NnCu8A6uFrxQF3ttayYAxUQVkIX5ypCikuXTNV9nAfuY3rNFIN3D9dbqkpR+KLSi7kvZ+PTogrJsD3P4qPK134cLzsnhtYaD+dMDHsMj0DrWy1at/ZZUTwV+Xr5iDE4ZprJLaNtArNK2QiuOoabEqBcDyhl4VETx0obc/Iznfw1oD9IUZ8SXH7nvrND2tgP1FDembPL9Dd2xJQViKS4MsowSuny8rQv440Y+4Vr/hAfu1Tp6lw95KHp4Lo4B0hkSF/x7/HfjlpE0rtbKcycrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBOSGdVeWSJEGT1WUBa+PpCxlCbUiskJlpLpZU+XS7Y=;
 b=O2xNo+Dshl+pa0sPARlQ2PQFbhlqKCQAwgV+cvL3O7vIZmbBPvspZ69ZEu7qX10TwuNICZMd8KRflV675SsC6pyNQ19+UViPYY09Wd2d+Ad4dMaw/ZBhP/wjeQ733f1yYE8jor8Ydn7NjxFd5Uk0Ake8xs1i57+BDe0OtM52JfE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 01:47:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 01:47:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Thread-Topic: [PATCH v5 3/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Thread-Index: AQHZbkJuKaO1FDkL3UmNHCNiJIKDla8wUu8A
Date:   Tue, 18 Apr 2023 01:47:36 +0000
Message-ID: <20230418014726.5q4lawwyxg7vqifh@synopsys.com>
References: <20230413195742.11821-1-quic_wcheng@quicinc.com>
 <20230413195742.11821-4-quic_wcheng@quicinc.com>
In-Reply-To: <20230413195742.11821-4-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY5PR12MB6108:EE_
x-ms-office365-filtering-correlation-id: ae8618b2-6286-4336-f717-08db3faee306
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9/kFDddMpM0Tpp+Tfwn1D/AwkQimfoVDbrI2+eS/N4HaT68t/PVFEdELhqVx2BqaBXQYvk1+biOrkcs8EvvUQhuy5QEZl10YHy/TIleylGEfOcvvLqbAL8fNGxP+Rjzl2w/7Uk0CzaL+8xTPVGOqQ7w9fpLgHOPoAdx8DHmbwpVxqmG9OjGdqrbqUTqGOZifWaBL1AMiv4JwFGY9KPfHVAdWAYVjgoGeGeaPg5qev0zSe9dwBOwo1aJ1taIWAk2RGrd1HTS/P8INQ6+TjVyjw5iGxcOkfIarW9JDSMcA/JXA/bRGYwgVFAxPp7y9IOQHh3XF/33FAjhJCPDAsNaFdZBU/AcnplRkeNsksxspJUAibG1/eT+2FkHbTzKTXLc/M+JPwH/3zGMJjZsNfBNeyMysyZH3FPja7qw8jzzHyZmwByqb0ujGu689q5qHMwFghWW2FEoivj++cF/hziCBvBPbdyVVOAqO9ICEqy7P8FzJkj1bbbGhi/SGMLGRQmkh1wVqYzursgnEz5BYZXl1JemoJrzGgKOOONJaLD6ODFM7LNOEBql6T96nsbLA1l/BfPaHBr19xMCLApXJUM8Kuoe815otKPz/FFHCmGKQMrM4u5cjDp/iG/5SEwqmWnL7eDx5AJ87jZXYfr3bNwM1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(1076003)(6506007)(6512007)(186003)(26005)(2616005)(83380400001)(6486002)(71200400001)(36756003)(54906003)(316002)(41300700001)(5660300002)(2906002)(4326008)(478600001)(6916009)(38100700002)(86362001)(38070700005)(8676002)(8936002)(66556008)(122000001)(64756008)(66446008)(66946007)(66476007)(76116006)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVPblByQWJFSnduOHRXRWhCZVFaK3hMajhvY0tBa2piVjhkYWRCNkgrY2c3?=
 =?utf-8?B?Q3lwN3k1bEQ2RGUwOU1oZS95cDJSeFJCb1k2bWdsb2J4N08yWUJSZGt1OGVp?=
 =?utf-8?B?aGZYSkw5RjY4bS9uNXErendORHlRMEg5c1RsNkcxWS9Ib3Q0KzJFbloxTUNC?=
 =?utf-8?B?c3hCUDl4M2tzTlRNU1VFR2wwOEd2SDIvdHV5NEF3eUkrK2NHVDA0UEc3UWdq?=
 =?utf-8?B?QnJZZFdHdGkvMkVyQVlvSTZ5eGhaY0hKZEllNGg1Z0hwc2wxMG9SVGYxaHFy?=
 =?utf-8?B?dmVncTEybFEzWm5lK3o0bWltTkY0bzVkN2JIUHhjbU9mcFZLLyt4V1Z4M2Yr?=
 =?utf-8?B?T21qYnZmbnkwbExEZ1djRXY1Y3E4TTlBRlVRZ25nbTRIbXNLOGw1ZmR5bFFy?=
 =?utf-8?B?MGwyVFpWdkpkem9FZjNLZU5hNWlPZ2g1R3h3elltc1pIMEhmMFlueS9LSXc0?=
 =?utf-8?B?T3JQNHJObnhrK2RvLysyQnlBTm9Ma3FFUWc3akNFdWlWcXI5WUErSCt3Rjd3?=
 =?utf-8?B?T3VZaFh1SEx1OFhPa0NNZWJDNVpMdWgrNUlveGU4SEdFTmZHQkhDY0luZTVB?=
 =?utf-8?B?enRTT2ZxQmU0QlkxNzlaeFptZzN2NzhWVjRtSk5RVWt2bnU3L3RBWjd6MFFr?=
 =?utf-8?B?OCtmQ2FXQkhBZVlkUFBEdXVxWm0vODdOcEFQSE5PLzMxNlBJQ09sYnE0Z0NF?=
 =?utf-8?B?KzVud1BzRlpJNzRDbm5NTy9wL2h5MWIvOTNHQUhDby8zZm9uZ2x5RTJpVi9r?=
 =?utf-8?B?V3RXei9Hc21CeThoQy9FRjlPQUJwQitsM2pwVGZEVHB6dkxGOTFzempmNlIy?=
 =?utf-8?B?eU52TzJHUnJQWU94QjNHZUE3NnJPdERUNWUxd3VpSTNLNlpUeUJrUFhKeEc1?=
 =?utf-8?B?cFdSVnNHWHB0NEVkWkgyUVR5N3JSVDlrUzVvajVpbHErOFFWR1duUzUrTmxm?=
 =?utf-8?B?UGtNOGZQd1kwVGJwRVRjeTUrRnFCKzJEaG9NaFFMSUN0clBGWDE1Yk43aUpv?=
 =?utf-8?B?MVhIbWRpbERUSE12ZFVrVG5ZUTJRTjNXZkQwd3Y1YW13cEZ5QllscFBqV2NM?=
 =?utf-8?B?b0pqY2xTUEdXK1VWZTlzbDN3N0I2bDJ6ZlhmbHN0TWtZb2FBYzZXM1ovOE5E?=
 =?utf-8?B?WEM5MDViZ3g0TTBoTG1WcFRYTUdsaDdVdDVSNEJwa3lqMEFLVjlieXlVYVRO?=
 =?utf-8?B?VlN1blYvRG53Y2Jva1FoeHp1M0pLbFhoRFI3QkdJdjNZY0Vnb2tzdkVsSXFp?=
 =?utf-8?B?VHRHc3p3eFdZVTRKVmFHK3ZHMWhmVlBmcHVyVVRuUVZxSjRUMndVSEwvRHZM?=
 =?utf-8?B?MkJpVEhDeGR5WldRQ2R5cGhRZSsvQWdpNVRoQk44a3kvVjQ4djltWmRlbDF6?=
 =?utf-8?B?Wjk4WU1nZTZrRTF3QitVL05nZUlWZ0h0MjByN1pTM3kwUDhJbWRLM2RTbXVP?=
 =?utf-8?B?b0JEYllhTkcwQS85LzljZFBvOGo5NFVyUmNhOXcwM2NHRjF6cFRBRTJhbHpU?=
 =?utf-8?B?T3FoMncxeXBONWlUM0g4RDg4T2dDL1NhSHkzMWVwby9DdkdDVUNhVzBuUDJo?=
 =?utf-8?B?TkE0NU56dWRHaExKbUdEeDlBRFZBQmtRaVVyaVg1UThoOEFibEVpa1VNVUtQ?=
 =?utf-8?B?MnluZ3l4SUh1NGg2TzRENG1hdFVUcS94TDA3dEdJb0hXQnBtdmd3RUFLVENn?=
 =?utf-8?B?anNIdTBJZnN6VERqcUNIcDZqM1VnS0t3UnZJNldPS1pPc2ZpZk1pS1BzQ1dl?=
 =?utf-8?B?bC9tMGxZbFRWSWQrVFRUNDhHWXhPMUVFNWkyaTNITnNzT2wrOEx6cVpuQm9M?=
 =?utf-8?B?ZTg0bFFvY3M2alNkbmtyWHlFRm44ZXZmVytGS2xGQUc3TzVHMEtBaGtRcVR0?=
 =?utf-8?B?emJzaVhuZzJ4VjFxL0VnY3Btczh2YW1LeHlWUTIwM3gyL3o2L0N5ZUVXZDdK?=
 =?utf-8?B?TlRLTElxZ0NVYTdVZ3RQSEdHcEc3Y2oydXExTWVkb2Q3ZElrK1ZxTVc2NnJP?=
 =?utf-8?B?Qy8wNlV4Qml1Y0NncWNxdTFPUnRXZ2JqS0tseitmenREbUIwSEdaQjJCNDFF?=
 =?utf-8?B?MS9wM290NVBXUEY4YlI4SWlWUkhLR2dBMUhJWk0vblpUQTFQK3Z5OXFhWEth?=
 =?utf-8?Q?5OI2NA90eo46oF3TPonSLY634?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1775F608E7CEA1449FA3025480FFA45D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EJ5q/Qdgh3D8pd8mBf7mzPlCM3m/0nJNenP7JmFziIXbDKssE74V2wb7J63vhFCvHWdh0fZyHFvwlq6TlvAvBq9/iV24InrhM3vkzCbd8xEk1XH0z+C/SGgepiJ6/8dK4ltLMA3CLNzxUzU8ikHL8VyRXf7oWr+NXnqtu/ETYeVXyBh7KONZWNWMNgNhYN2TK6fD4KRJVWP8B2d5LVgxQMZx07qtvloAx+ju9vaMdcJ0/i/dRD/x0/YpnIbrav3h5l6+dWLvXXkoYRui9HEGzVrQXiHK8rybGrWK+Na6RfU3q2s92oepJuBTeTpPCD0CwJxXXKGaR8q4yr8BOSAsJEdLxLWIF1eosr7TJ7odeRyF9SjRKEc2PwAj5uCIwci3U1GciRC+Br3CS+TiOyYCSLgZ8FNGcgb+lGc9tewOb8zmQwTNSURKnL+vsNoM0fD3oyqbLoBFkCV2W+ceHveKqhBjcH5JfmNEaIhdLfgSx4DglAbKI+4P0vQejMJ4gYkSKEPD4APLamyQeWyO7S/WVNVzpffxrPZkgHwfjnC1XD8meD0jQuMjwCSSXfbKq87jmYRxh9FZCT4uTWHsMQdZbLJKIwq4q2crMbRRy+pFBXdaRgdrgoCjUuXTFpe/cxeNdmCzbZH9HQtF4KrJx0SiToj5VAj+AHFneCWLOaA9euQAqW+exnPYxkAwv1dbp7nV3/kNIdun0mRJtJABRgvIusbadqDiKMhZdAdg+haknT2Nb8NHxDZep/aG2SvryWQd/UM4SdVx0Bm+kGGmk78Zj53CCk+BgARmo0IbbHsninThCPzwd6BfD8F2qCjlioL4ouDyG8UBdDpRnx9t/l9rFkPnz/buaeyMsswB8cHWxFIvclMGCUeEgzUIXozTbx34gX105zOybwB4ntScB74Yow==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8618b2-6286-4336-f717-08db3faee306
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 01:47:36.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYKPHborzZv1e970fw+ic/0knsGEt3owycoAdV3+XxdxPqJfArP2vxRjOpibapbC2hcGhEDoTGiMnlJ5w4Okbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
X-Proofpoint-ORIG-GUID: w_FEL_QiR7fMFm-vy9bGngWzWkdUD0ND
X-Proofpoint-GUID: w_FEL_QiR7fMFm-vy9bGngWzWkdUD0ND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMTMsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gU2V2ZXJhbCBzZXF1
ZW5jZXMgdXRpbGl6ZSB0aGUgc2FtZSByb3V0aW5lIGZvciBmb3JjaW5nIHRoZSBjb250cm9sIGVu
ZHBvaW50DQo+IGJhY2sgaW50byB0aGUgU0VUVVAgcGhhc2UuICBUaGlzIGlzIHJlcXVpcmVkLCBi
ZWNhdXNlIHRob3NlIG9wZXJhdGlvbnMgbmVlZA0KPiB0byBlbnN1cmUgdGhhdCBFUDAgaXMgYmFj
ayBpbiB0aGUgZGVmYXVsdCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVu
ZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyB8IDUzICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IGluZGV4IDBiYjQ5MjY5MzNiNi4uOTcxNWRlOGU5OWJjIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gQEAgLTEzOSw2ICsxMzksMjQgQEAgaW50IGR3YzNfZ2FkZ2V0X3NldF9saW5r
X3N0YXRlKHN0cnVjdCBkd2MzICpkd2MsIGVudW0gZHdjM19saW5rX3N0YXRlIHN0YXRlKQ0KPiAg
CXJldHVybiAtRVRJTUVET1VUOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2VwMF9y
ZXNldF9zdGF0ZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXVuc2lnbmVkIGludAlkaXI7
DQo+ICsNCj4gKwlpZiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBfU0VUVVBfUEhBU0UpIHsNCj4gKwkJ
ZGlyID0gISFkd2MtPmVwMF9leHBlY3RfaW47DQo+ICsJCWlmIChkd2MtPmVwMHN0YXRlID09IEVQ
MF9EQVRBX1BIQVNFKQ0KPiArCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+
ZXBzW2Rpcl0pOw0KPiArCQllbHNlDQo+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3
YywgZHdjLT5lcHNbIWRpcl0pOw0KPiArDQo+ICsJCWR3Yy0+ZXBzWzBdLT50cmJfZW5xdWV1ZSA9
IDA7DQo+ICsJCWR3Yy0+ZXBzWzFdLT50cmJfZW5xdWV1ZSA9IDA7DQo+ICsNCj4gKwkJZHdjM19l
cDBfc3RhbGxfYW5kX3Jlc3RhcnQoZHdjKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAg
ICogZHdjM19lcF9pbmNfdHJiIC0gaW5jcmVtZW50IGEgdHJiIGluZGV4Lg0KPiAgICogQGluZGV4
OiBQb2ludGVyIHRvIHRoZSBUUkIgaW5kZXggdG8gaW5jcmVtZW50Lg0KPiBAQCAtMjU2MywxNiAr
MjU4MSw5IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJCXJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZHdjLT5l
cDBfaW5fc2V0dXAsDQo+ICAJCQkJbXNlY3NfdG9famlmZmllcyhEV0MzX1BVTExfVVBfVElNRU9V
VCkpOw0KPiAgCQlpZiAocmV0ID09IDApIHsNCj4gLQkJCXVuc2lnbmVkIGludCAgICBkaXI7DQo+
IC0NCj4gIAkJCWRldl93YXJuKGR3Yy0+ZGV2LCAid2FpdCBmb3IgU0VUVVAgcGhhc2UgdGltZWQg
b3V0XG4iKTsNCj4gIAkJCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
LQkJCWRpciA9ICEhZHdjLT5lcDBfZXhwZWN0X2luOw0KPiAtCQkJaWYgKGR3Yy0+ZXAwc3RhdGUg
PT0gRVAwX0RBVEFfUEhBU0UpDQo+IC0JCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2Ms
IGR3Yy0+ZXBzW2Rpcl0pOw0KPiAtCQkJZWxzZQ0KPiAtCQkJCWR3YzNfZXAwX2VuZF9jb250cm9s
X2RhdGEoZHdjLCBkd2MtPmVwc1shZGlyXSk7DQo+IC0JCQlkd2MzX2VwMF9zdGFsbF9hbmRfcmVz
dGFydChkd2MpOw0KPiArCQkJZHdjM19lcDBfcmVzZXRfc3RhdGUoZHdjKTsNCj4gIAkJCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCQl9DQo+ICAJfQ0KPiBA
QCAtMzg0NywxNiArMzg1OCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2Rpc2Nvbm5lY3Rf
aW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjLT5zZXR1cF9wYWNrZXRfcGVuZGlu
ZyA9IGZhbHNlOw0KPiAgCXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3Yy0+Z2FkZ2V0LCBVU0JfU1RB
VEVfTk9UQVRUQUNIRUQpOw0KPiAgDQo+IC0JaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQ
X1BIQVNFKSB7DQo+IC0JCXVuc2lnbmVkIGludCAgICBkaXI7DQo+IC0NCj4gLQkJZGlyID0gISFk
d2MtPmVwMF9leHBlY3RfaW47DQo+IC0JCWlmIChkd2MtPmVwMHN0YXRlID09IEVQMF9EQVRBX1BI
QVNFKQ0KPiAtCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzW2Rpcl0p
Ow0KPiAtCQllbHNlDQo+IC0JCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5l
cHNbIWRpcl0pOw0KPiAtCQlkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydChkd2MpOw0KPiAtCX0N
Cj4gKwlkd2MzX2VwMF9yZXNldF9zdGF0ZShkd2MpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9p
ZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gQEAgLTM5
MTAsMjAgKzM5MTIsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQo
c3RydWN0IGR3YzMgKmR3YykNCj4gIAkgKiBwaGFzZS4gU28gZW5zdXJlIHRoYXQgRVAwIGlzIGlu
IHNldHVwIHBoYXNlIGJ5IGlzc3VpbmcgYSBzdGFsbA0KPiAgCSAqIGFuZCByZXN0YXJ0IGlmIEVQ
MCBpcyBub3QgaW4gc2V0dXAgcGhhc2UuDQo+ICAJICovDQo+IC0JaWYgKGR3Yy0+ZXAwc3RhdGUg
IT0gRVAwX1NFVFVQX1BIQVNFKSB7DQo+IC0JCXVuc2lnbmVkIGludAlkaXI7DQo+IC0NCj4gLQkJ
ZGlyID0gISFkd2MtPmVwMF9leHBlY3RfaW47DQo+IC0JCWlmIChkd2MtPmVwMHN0YXRlID09IEVQ
MF9EQVRBX1BIQVNFKQ0KPiAtCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+
ZXBzW2Rpcl0pOw0KPiAtCQllbHNlDQo+IC0JCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3
YywgZHdjLT5lcHNbIWRpcl0pOw0KPiAtDQo+IC0JCWR3Yy0+ZXBzWzBdLT50cmJfZW5xdWV1ZSA9
IDA7DQo+IC0JCWR3Yy0+ZXBzWzFdLT50cmJfZW5xdWV1ZSA9IDA7DQo+IC0NCj4gLQkJZHdjM19l
cDBfc3RhbGxfYW5kX3Jlc3RhcnQoZHdjKTsNCj4gLQl9DQo+ICsJZHdjM19lcDBfcmVzZXRfc3Rh
dGUoZHdjKTsNCj4gIA0KPiAgCS8qDQo+ICAJICogSW4gdGhlIFN5bm9wc2lzIERlc2lnbldhcmUg
Q29yZXMgVVNCMyBEYXRhYm9vayBSZXYuIDMuMzBhDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
