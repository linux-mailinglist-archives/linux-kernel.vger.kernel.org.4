Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538C46BA0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCNUpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:45:31 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC10CC671;
        Tue, 14 Mar 2023 13:45:29 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EJWVlc020968;
        Tue, 14 Mar 2023 13:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=6OcxZQC7V32qD+M/D5D18PUTYEyWTLH+VpnCSwMSLSo=;
 b=W48utalcX4lhn3MBcQf3hxisA/6YFN5HHoESXgjSzl8CbH4ci5Ff66ipjpVcUnA0tyDf
 /KyoxJpH1Gn3GWFkaQL1CNmq4CONzJ6Fa9bbX51u65Uh7FBsWLjKuffPL/wdnkJa/LZb
 vqfrGKFELEg3GaUFPY+Ok0vZze/YuYd1GfYd+LmTJrQJPWg/bg46SVsjU5mEvdXa0LD9
 FqhTWD426nL72BfCkIBrAKac2+wczIZHcGLMweWo4UKQw80Fs5161LFsRr1hvgNUBWoI
 RVYwL4sXxdkv52Fsz7CBF99RFzxX6Za9/1+yNQ8pbUvvwBUv9nnNJhqB5tMRgtKhwzUJ xw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p9ar4ca6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 13:45:23 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BB053400D9;
        Tue, 14 Mar 2023 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678826723; bh=6OcxZQC7V32qD+M/D5D18PUTYEyWTLH+VpnCSwMSLSo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Yf/V/5QMy8VrQQlU6VkuCayBR4TgVBhllSt0yQIXb+tlm7kjH7rcTjhjDMxgkHDDD
         AGxOZDaSBxl0KzftG8CzNWtF9rquolAq4rnLtMrqgRCkRiJ5okrN9YJ4X99vOi3Cay
         kyisRRYIVBCYtWN/itcxwJ/+O/j4j6HcQixQXHchXhLUQgHwkTau7gEA61/W+jmcWp
         XmNdKr/oDhRNtDOJyp9I3RH2UYe3PmQ/R3YL90F1iRUFgeGnvzOaGL4Te4hnoxFeQ+
         vHZxExZUdiIDCMd1so4EYzfLQBjqTz8PNmE/HqEFW2iC/dOedE6FWfJvFeuk0Hw9az
         3sTkop+CkeLJw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D4686A005C;
        Tue, 14 Mar 2023 20:45:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3C61840119;
        Tue, 14 Mar 2023 20:45:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="X19PUGdG";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbI1J95z7NdolKzU0r/sALJJeKs5UWUAayNy9KxOh5lZTKYiJbopcdsO+QtUDGbqpOgHeJA5mUxAfQlUyskqngXOPf4wSp+yB8VC1hqTnwQ0jzD5OJaZGvEBHB22sTm9abWmAjV8ovurPSOKXOLJYLW2FnzFkOTIDgMkB1PvFHTs/7MY9ILO0zwLAlTuBkZ8//SA9ilj1zvLlk1u+cyC4/1Jof39fcKSQgeT72WOko+bLoV5EHad9iOW8Np6obEYnNQIgYqeqcggf453gYl5Znk2D2nPOGjztSV0e8cW8sQ8hkXJvjSw2+09oIz6VfUnQqfkSYSDOQIJTm+RmKUPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OcxZQC7V32qD+M/D5D18PUTYEyWTLH+VpnCSwMSLSo=;
 b=gGr1amc4K2xqznIk/ndMn2yyltYQV4RCgvnBCGADU1sSpYjPPkwL6n6mAnjkrqhU/6Gz1Qi+33OPaIRTmNmsbuR0SUr25Txj4HCPb8oG+dr4ur31VfzE+FVTByZjKp15eKWb4vEcRVWKiXaV1FZ9rAJvkau6ic/VeQabWzzhaSyb2OQqzNzgjy4tr0UjouztaZvPJ5SMPyJUj6/ahMyl5qAQuC65R5yvVNEt3+i3z9df4Z4sGEnsAt/9iIw2i5vAlMNpXT0wkNXjcYbexiqtP0iTuL5errQrfjtXekrn+EkgZdYhBGzd0oCa8HnwmApEyvwM9kCtxndyFiq9mhc7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OcxZQC7V32qD+M/D5D18PUTYEyWTLH+VpnCSwMSLSo=;
 b=X19PUGdG6VHu2Q4/XlusI3GmEPcWbc7RjD7wHg8+VE4cN6bGeU4zd1BdqwwCnJve5lY2g1hy3oPK9imyBXxXFZF8Pj/v72ClCTvjR+yJBPJGQpMovFBovbH/VCvT8SnQLjFhwqEnuSYwmJ+N0aZv0GsLYV/gCCWuTdQufVGzHOI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 20:45:18 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 20:45:18 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Index: AQHZVdkm2qliMtpSnkaUilVaMBFAZa75KJuAgAGELgCAAAtFAIAAB/sA
Date:   Tue, 14 Mar 2023 20:45:18 +0000
Message-ID: <20230314204510.4n72sdm2xk3viy3e@synopsys.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
 <20230313202655.srqfddpn5r36zt3o@synopsys.com>
 <7064988c-9975-64c3-25c6-e1330ed723a4@quicinc.com>
 <20230314201636.mfmjrgluckyk5xhy@synopsys.com>
In-Reply-To: <20230314201636.mfmjrgluckyk5xhy@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5080:EE_
x-ms-office365-filtering-correlation-id: 786a2ef8-3cce-4a60-8960-08db24cd058e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjZPGKQBbDMjZ2kBMqv0cgbQqz2RhJySVOnqi+NRqQ6REWAf3QxFCGI96tsLOV0L5gNy+MB44toYFSh+87mndwrtBykkULdMqpRhh369bTY+d8fUVwuM3FDi6OobEF1dh87VRFGfoI86xiFulkxzAOMjHCydR4UMPuLvd8o1dqI7+WfTCJ2xlifbdaHBjJZWw+NUzsfBKKu8Nrbld48M3Wiu1hfe62cx6yvud/95gmO4ThcY5TN2uVYQ5OMnzq1a6W66bY+BFRz2dgELjfC+xFmrbRmUmhAm/GsMyLN3Hw//+5bfb7cJTEnMdn58ZNBTF/Z0ESH2XF7rZyrLxDsV7y7zFpuBV+jdW2ekw+rc0utPTO2c4RcpXN0agyasSM80KgOMAVnGlXxFUrzbCO8Yp17l3uvlw5oPZ+V8NsR8fYrnz+PuD5biqxLENwLWhTwSVhKYYSrbaz8fHbIwiZWX8+M3g1DjW/bXyneSdTM76dmr+rDRdvZTyK5qzeLD3SYtOD2Z/7dz4lPqKT3gTA54eitqHxJbDnDo98R5OqKuJjnz3j71KyHhFd+7MDKLs0Y8fLeavOipTMUuvInv9j6g2INbw0L4qnhueUVskEcdTh2RvoAkFP8YYFJ1dLTx9b3ENtqC6pjY8yvAsPrOK7PFm8C9Vx33eiP2QRPKjzxVJjb6elf+3CJUiZIKhv5p6GGGo2Z97pfXEa4LaE4iTRb8mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(8936002)(76116006)(66946007)(66476007)(6916009)(66556008)(4326008)(64756008)(8676002)(66446008)(41300700001)(5660300002)(38100700002)(36756003)(86362001)(15650500001)(38070700005)(122000001)(2906002)(2616005)(53546011)(6512007)(26005)(186003)(6506007)(1076003)(6486002)(71200400001)(54906003)(316002)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVpUyt0cHRjTlBXWkIyTHBSS2FNalFXMlBuTnM2d3QzOCtPS1V2RzhMZ2lv?=
 =?utf-8?B?UFI3VzF2QTJ3aDRhMCtNNkM2V25sV0k2RVFnR0RTaXZLWDZyd0FSMHRpVUxG?=
 =?utf-8?B?R3hLTW5BblAvY3JtcTd0ZXJpSGI4eU5QL3FaUzI0Z0tIcWdqRTVEVC9Hd3R5?=
 =?utf-8?B?R0VDZS9vTXVBaUpHaHJPVVlXaVZYYjRRclVPTHB0OUVtTHhWVnpBWkdkVUxl?=
 =?utf-8?B?VTN4N1FoQkp2cTlNN3NTWDhHMExUNlJOQVI3cWZSaytCRlhsMUdqa3VseGdB?=
 =?utf-8?B?bkdaTEpXcWc3dmJGS2I3UEFzbVJpMW9UdkpRaFFOVjVjMGhORjBRN0Eyakkv?=
 =?utf-8?B?bENaS1dINmt0dXc3NTFQS2dsKzluUEg0aFhHYTZSNzlDV3FaUTB0ZjY0TCtw?=
 =?utf-8?B?NVBiNUx6Rk1WMmpUK05yTkJ1VDRIZ3JuZFFuL3oxWmR2THBjYWxWZnZDamRO?=
 =?utf-8?B?bEJSWGFzWTdUbWxOTUIzK3I1UG1jWGJPT0RjNVlvQ2VXeGhaUlRiTlBIdFZy?=
 =?utf-8?B?d0trVExBWFhiMDBKUXA1R2JOc0VidjBFZXpFMSsvZVhVc3lzcEZMTFQ0QVNo?=
 =?utf-8?B?NGdrV2hIYVVnSDFjd0krL2FNTi94VzdRc25oaDRJN1ZPSWs2cDJ0VnE1S01i?=
 =?utf-8?B?b1llOHlnbkdWVm5QRUhYVm5iUjZCUW5aL3hNOXV1U243Q3NpOEU4akwwT2Vq?=
 =?utf-8?B?aXZadFdxUEQxWVBjOEo1clZ2Ty9GTldINVVVZktHNS9OWCtHejdKdjlDdk9G?=
 =?utf-8?B?SWdpUFIyRng3RTM3d0FMaUhlRSt0NnRJNXhjWFdya29tb21ocmJyaml2YTAz?=
 =?utf-8?B?UXEvQ21pWDlWaE9FZTROc3o0TlMzV1M4d1pWWFRMQWpraVFmNDJORTRqRWtY?=
 =?utf-8?B?Ulpvc3oyWXkyaVR0ZkhYL2ZsUk1HZlhFSmVwK3IzdW13bHBOYll5a2xsc1By?=
 =?utf-8?B?TjhmYzhYZ3FiL29zbDcwWWtVM2toVHdTU29mYy9kY0tpMTBVcmpZdW5yTDc5?=
 =?utf-8?B?UlVpSnNzWjdWZ3VNa0JZYXVkUDVvczBPUlZhNWRBSmpRbm4weWpoc3YrdjJr?=
 =?utf-8?B?Uy9kakFTSURyVXZibndsMzQxS1M4SGlFaWRSNFZKVndmSSt1V2UzMnVYQXFU?=
 =?utf-8?B?NEV6Wlhyb2ZDSUtSVlFyeHY2U1BrZGJHT2I1anFXWTJqR0hUMWZDdk1YMmFp?=
 =?utf-8?B?bUJlUFdxMGF5SUxmbGVMckprN2JaL0hMRzk4eW5kNExIdkM0YmVxUUxXTmJR?=
 =?utf-8?B?WTFjUWpKNk5rbXZ3eVllQk1SK0sybEdrVHNkZWRERjg0Wm9ub0Z2ektkVkZL?=
 =?utf-8?B?Q1pMMDQ3VW05SDlsNlpuV1VidUNWdVVqTmJ3NHVuWTF5Y3NrdEhhK2NWQzRw?=
 =?utf-8?B?REROWGgvbUZyWFVBZXNRM3lTNy9PSVVKVWRiSjRjQm80ZTBHZml5RG5VRjhU?=
 =?utf-8?B?VUhpUjg4YjI0VlI2N3diNjc1K3FoZy9BUE1vWk5EbkE2dDlaVGVUZGNVOCtn?=
 =?utf-8?B?QU5TV0pycktCZXJ0NGhUZGZLU3V4L3lCcmFuL1Vwc21NdnZ6eXlIeStGTzNN?=
 =?utf-8?B?UGtMVStGYjBQaG9FcXFMQklGTTVQYW1LMWZzNjl0NEg1bVdLWExCalc3UHhr?=
 =?utf-8?B?VmdsRnpTK1pxMmJFcTdkWEV6MStPYUVJdHgzZU5WRVNFQkpsOFFwYU9FcGow?=
 =?utf-8?B?S01Yc0NsNEpHeHRidkxIekQzNS95YTl1TzZEaVczc1pLcHFSQ0doL2xwMUl6?=
 =?utf-8?B?NVluZ0g2QmZJUk5Qa0o5QWJsd2hnMUwvdnV4ZHE3OE1UUVBySFVIWXJvcWJv?=
 =?utf-8?B?aERkaGhVTjlsQVp0bDh5OUhQSWVaclQvTWVJcjExVTBWQ3lyZXRZOS9DSHRJ?=
 =?utf-8?B?RXJ6WDRhN25mTW9SYUNCbG4raDZyVDRLMk1EMUcrVU8rRW0wNUpKNnFTN1Q3?=
 =?utf-8?B?OWNHVW0zZTAwZjI1TFdKbUkwaTNycXQ0SHBQZHV3OXNTVFY5bnJDNG5CZjhG?=
 =?utf-8?B?cFZsZENWYlhRZG5tQ3VBajlnTUNvOXVIYlFXaGMwZXFBcHFhZ3R3ZTVOWHky?=
 =?utf-8?B?U0dGOWlGeUx5Ujk0M1V3NjRUMnhTYlkwZWZMZGNyd2s3bzUvWm1yR3BqUjlz?=
 =?utf-8?Q?I0/CZqqegG4pypc2VF+tK6WXo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <695BD1678DB50549B27396AEC9FE26F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /fSCR5LhM4EplgPwoPvjXt3/Z7eFyizrqCZyBlEVcckHK9SDac4jsLT5OeBFp/CAe64sG0CY8wjTLIfzXSGaPGaFUsv9SllJrucfw1Tm1PdWMG5PKPArbvK/zIMOZwVdemPMJu8yOWpDv08A47MYvSfXc3qjH1/R9/RUa0ni6bilNUeJZPTiR9VTcpyuqUxGof0NlggsFmR71HcOcTqVXmHt1scmP6jgN7Br3dCubO/bB29etP9n3KWjhcZKKqfVWQPZSoVqfQtIFyIM3ShHt0RllNAJ71fjz8UF+k3TGU9qHxiQUQDagg+ear/+jTbHrlxsQIYrngauW3ZD4Hj5f3eBwEw3w20P/wzMg1KZVJ5hlofKMfTfHz2RnvbEgheDrVEQKDib/VOt7ntLrEfY12ivjk20BEQcgbTT1cqHko8fpq5LlfPSQYp136IHlSoUEcgb4E0Ff6YAZAH0lC1j6sqv4ZsCb3kc8kXdEvMMvr9FQcpgiHDYstuCIeOs+/vaarwjWkFVkDdvAyM2KOlKnApUjjYMLr/ByC9N8CyFHeyyQ8N0ejVeS8LpaUiI9215LJtkV0ZfDfqm6O0KIuEFhCWW4zEKk4nzBWq0AT+bp1neOU9EhQx5KdK1hPVKts4vHspbauJvIZkjmKltwtxOpvLpWhRh8sYpNGDJGpq6vlnrEPRKoHqZKdGWcxUh4tlPMO4qvCWxhudgopkj7/JMg/g7SrQVZ+N/n0xbFs0a7f0EKa4L3vLzkMZVOpioAFlamOv8lRCvOTejUkWHtWX0fgcXqihjx1gcQ0sLlMf1Xt05Vfn1jakmrP99x+cWs0QYCFDkHNZGvh6mxoI/d8vPDOtgx1nszX82wRvuFBjl7I2TOBb2v/Ao6oGdCUX8/+f69/2/bJHIiHASwoIxNT5RtLe2a/3ATpuitQbB40NKQXQ=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786a2ef8-3cce-4a60-8960-08db24cd058e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 20:45:18.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXsuHnnI6ZbQ/s4QcTtOpqfEzdC0JhkHoFpWCD/nYEdBtJSaBy5IKFcKhvOls/iilI1byYZ4aTGTxkj6eqpO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
X-Proofpoint-GUID: m6h5w8IgpfTtaaMlRps4dcXB0nPD0nuV
X-Proofpoint-ORIG-GUID: m6h5w8IgpfTtaaMlRps4dcXB0nPD0nuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_13,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMTQsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVHVlLCBNYXIg
MTQsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBPbiAzLzEzLzIw
MjMgMToyNyBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBNYXIgMTMsIDIw
MjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+IFdoZW4gaG9zdCBzZW5kcyBhIHN1
c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiA+ID4gPiB0aGUgc3Vz
cGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3VwZXINCj4g
PiA+ID4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiA+ID4gPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVu
Y3Rpb24gc3VzcGVuZCBjYWxsYmFjay4NCj4gPiA+ID4gDQo+ID4gPiA+IERlcGVuZGluZyBvbiB0
aGUgcmVtb3RlIHdha2V1cCBjYXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiA+ID4g
PiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQg
cmVzdW1lIHRvDQo+ID4gPiA+IHN0YXJ0IGRhdGEgdHJhbnNmZXIgYWdhaW4uDQo+ID4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVp
Y2luYy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi9mX2VjbS5jICAgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMgfCA2MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X2V0aGVyLmggfCAgNCArKysNCj4gPiA+ID4gICAzIGZpbGVzIGNoYW5nZWQs
IDEzNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl9lY20uYw0KPiA+ID4gPiBpbmRleCBhN2FiMzBlLi5kNTBjMWE0IDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiA+ID4gPiBAQCAtNjMzLDYg
KzYzMyw4IEBAIHN0YXRpYyB2b2lkIGVjbV9kaXNhYmxlKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYp
DQo+ID4gPiA+ICAgCXVzYl9lcF9kaXNhYmxlKGVjbS0+bm90aWZ5KTsNCj4gPiA+ID4gICAJZWNt
LT5ub3RpZnktPmRlc2MgPSBOVUxMOw0KPiA+ID4gPiArCWYtPmZ1bmNfc3VzcGVuZGVkID0gZmFs
c2U7DQo+ID4gPiA+ICsJZi0+ZnVuY193YWtldXBfYXJtZWQgPSBmYWxzZTsNCj4gPiA+ID4gICB9
DQo+ID4gPiA+ICAgLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCj4gPiA+ID4gQEAgLTg4NSw2ICs4ODcs
NjggQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb25faW5zdGFuY2UgKmVjbV9hbGxvY19pbnN0
KHZvaWQpDQo+ID4gPiA+ICAgCXJldHVybiAmb3B0cy0+ZnVuY19pbnN0Ow0KPiA+ID4gPiAgIH0N
Cj4gPiA+ID4gK3N0YXRpYyB2b2lkIGVjbV9zdXNwZW5kKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYp
DQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShm
KTsNCj4gPiA+ID4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBlY20tPnBvcnQu
ZnVuYy5jb25maWctPmNkZXY7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoZi0+ZnVuY19zdXNw
ZW5kZWQpIHsNCj4gPiA+ID4gKwkJREJHKGNkZXYsICJGdW5jdGlvbiBhbHJlYWR5IHN1c3BlbmRl
ZFxuIik7DQo+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKwlEQkcoY2RldiwgIkVDTSBTdXNwZW5kXG4iKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWdl
dGhlcl9zdXNwZW5kKCZlY20tPnBvcnQpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+
ICtzdGF0aWMgdm9pZCBlY21fcmVzdW1lKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gPiA+
ICt7DQo+ID4gPiA+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4gPiA+
ID4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBlY20tPnBvcnQuZnVuYy5jb25m
aWctPmNkZXY7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIElmIHRoZSBm
dW5jdGlvbiBpcyBpbiBVU0IzIEZ1bmN0aW9uIFN1c3BlbmQgc3RhdGUsIHJlc3VtZSBpcw0KPiA+
ID4gPiArCSAqIGNhbmNlbGVkLiBJbiB0aGlzIGNhc2UgcmVzdW1lIGlzIGRvbmUgYnkgYSBGdW5j
dGlvbiBSZXN1bWUgcmVxdWVzdC4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwlpZiAoZi0+ZnVu
Y19zdXNwZW5kZWQpDQo+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCURC
RyhjZGV2LCAiRUNNIFJlc3VtZVxuIik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlnZXRoZXJfcmVz
dW1lKCZlY20tPnBvcnQpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMg
aW50IGVjbV9nZXRfc3RhdHVzKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gPiA+ICt7DQo+
ID4gPiA+ICsJcmV0dXJuIChmLT5mdW5jX3dha2V1cF9hcm1lZCA/IFVTQl9JTlRSRl9TVEFUX0ZV
TkNfUlcgOiAwKSB8DQo+ID4gPiA+ICsJCVVTQl9JTlRSRl9TVEFUX0ZVTkNfUldfQ0FQOw0KPiA+
ID4gDQo+ID4gPiBOZWVkIHRvIGNoZWNrIHRoZSB1c2IgY29uZmlndXJhdGlvbiBpcyBpZiBpdCdz
IHdha2V1cF9jYXBhYmxlLg0KPiA+ID4gDQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4g
K3N0YXRpYyBpbnQgZWNtX2Z1bmNfc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmLCB1OCBv
cHRpb25zKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190
b19lY20oZik7DQo+ID4gPiA+ICsJc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNt
LT5wb3J0LmZ1bmMuY29uZmlnLT5jZGV2Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJREJHKGNkZXYs
ICJmdW5jIHN1c3AgJXUgY21kXG4iLCBvcHRpb25zKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWYt
PmZ1bmNfd2FrZXVwX2FybWVkID0gISEob3B0aW9ucyAmIChVU0JfSU5UUkZfRlVOQ19TVVNQRU5E
X1JXID4+IDgpKTsNCj4gPiA+IA0KPiA+ID4gU2FtZSBoZXJlLiBDaGVjayBjb25maWcncyBibUF0
dHJpYnV0ZXMgaWYgaXQncyByZW1vdGUgd2FrZXVwIGNhcGFibGUNCj4gPiA+IGJlZm9yZSBhcm1p
bmcgZm9yIHJlbW90ZSB3YWtldXAuDQo+ID4gPiANCj4gPiBEb25lLiBJIHdpbGwgYWRkIHRoYXQg
Y2hlY2sgZm9yIGFib3ZlIHR3byBjYXNlcy4NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChvcHRp
b25zICYgKFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfTFAgPj4gOCkpIHsNCj4gPiA+ID4gKwkJaWYg
KCFmLT5mdW5jX3N1c3BlbmRlZCkgew0KPiA+ID4gPiArCQkJZWNtX3N1c3BlbmQoZik7DQo+ID4g
PiA+ICsJCQlmLT5mdW5jX3N1c3BlbmRlZCA9IHRydWU7DQo+ID4gPiA+ICsJCX0NCj4gPiA+ID4g
Kwl9IGVsc2Ugew0KPiA+ID4gPiArCQlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gPiA+ID4g
KwkJCWYtPmZ1bmNfc3VzcGVuZGVkID0gZmFsc2U7DQo+ID4gPiA+ICsJCQllY21fcmVzdW1lKGYp
Ow0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0dXJu
IDA7DQo+ID4gPiANCj4gPiA+IE5lZWQgdG8gcmV0dXJuIG5lZ2F0aXZlIGVycm9yIGlmIFNldEZl
YXR1cmUgZmFpbHMuIFdlIHNob3VsZCBmaXggdGhlDQo+ID4gPiBjb21wb3NpdGUgbGF5ZXIgdG8g
YWxsb3cgZm9yIHByb3RvY2FsIFNUQUxMIGhlcmUuIEhvc3QgbmVlZHMgdG8ga25vdyBpZg0KPiA+
ID4gaXQgc2hvdWxkIHByb2NlZWQgdG8gcHV0IHRoZSBmdW5jdGlvbiBpbiBzdXNwZW5kLg0KPiA+
ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBUaGluaA0KPiA+ID4gDQo+ID4gDQo+ID4gQ291bGQg
eW91IHBsZWFzZSBjbGFyaWZ5IHdoYXQgU2V0RmVhdHVyZSBmYWlsIGhlcmUgbWVhbnM/IFRoZSBo
b3N0IHB1dHMgdGhlDQo+ID4gZnVuY3Rpb24gaW4gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSB0aHJv
dWdoIHRoaXMgU2V0RmVhdHVyZSByZXF1ZXN0Lg0KPiA+IElmIHRoZSBkZXZpY2UgaXMgbm90IGNv
bmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAgKGJtQXRycmlidXRlcyB3YWtldXAgYml0KSwNCj4g
PiBsaWtlIHlvdSBtZW50aW9uZWQgYWJvdmUgd2Ugc2hvdWxkIG5vdCBhcm0gdGhlIGZ1bmN0aW9u
IGZvciByZW1vdGUgd2FrZXVwLg0KPiA+IEJ1dCB0aGUgaG9zdCBpcyBmcmVlIHRvIHB1dCB0aGUg
ZnVuY3Rpb24gaW4gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSBhbmQgd2FrZQ0KPiA+IGl0IHVwIHRo
cm91Z2ggaG9zdCBpbml0aWF0ZWQgZnVuY3Rpb24gcmVzdW1lIHJpZ2h0Pw0KPiA+IA0KPiANCj4g
SSBtZWFuIGlmIHdlIHdhbnQgdG8gdGVsbCB0aGUgaG9zdCB0aGF0IGEgZmVhdHVyZSBjYW5ub3Qg
YmUgc2V0IG9yIHRoYXQNCj4gaXQgZG9lc24ndCBleGlzdCwgd2Ugc2hvdWxkIHJlc3BvbmQgd2l0
aCBhIHByb3RvY29sIFNUQUxMLiBIb3cgdGhlIGhvc3QNCj4gcmVzcG9uZCB0byB0aGUgcmVqZWN0
ZWQgU2V0RmVhdHVyZSByZXF1ZXN0IGlzIHVwIHRvIHRoZSBob3N0LiBCdXQgd2UNCj4gc2hvdWxk
IGF0IGxlYXN0IGxldCB0aGUgaG9zdCBrbm93IHRoYXQuDQo+IA0KPiBJJ20gc3VnZ2VzdGluZyB0
byByZW1vdmUgdGhlIHNldHRpbmcgb2YgdmFsdWUgPSAwIGluIGNvbXBvc2l0ZS5jOg0KPiANCj4g
LS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IEBAIC0yMDAwLDcgKzIwMDAsNiBAQCBjb21wb3NpdGVfc2V0
dXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwgY29uc3Qgc3RydWN0IHVzYl9jdHJscmVxdWVz
dCAqY3RybCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFUlJPUihjZGV2LA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmdW5jX3N1c3BlbmQoKSBy
ZXR1cm5lZCBlcnJvciAlZFxuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2YWx1ZSk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSAw
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiANCj4gDQo+IGkuZS4gd2Ugc2hvdWxkIGFs
bG93IHRoZSByZXR1cm4gdmFsdWUgdG8gZ28gdGhyb3VnaC4NCj4gDQoNCkFsc28sIEkgaW1hZ2lu
ZSB0aGVyZSBhcmUgY2FzZXMgd2hlcmUgd2UgZG9uJ3Qgd2FudCB0aGUgaG9zdCB0byBwdXQgdGhl
DQpkZXZpY2UgaW4gc3VzcGVuZCBiZWNhdXNlIGl0IGxhY2tzIHJlbW90ZSB3YWtldXAuIGUuZy4g
YSBISUQgZGV2aWNlIHN1Y2gNCmFzIGEga2V5Ym9hcmQgKHRob3VnaCBpdCdzIGEgYml0IG9kZCB0
byBzZWUgb25lIHdpdGhvdXQgcmVtb3RlIHdha2UNCmNhcGFiaWxpdHkpDQoNClRoYW5rcywNClRo
aW5o
