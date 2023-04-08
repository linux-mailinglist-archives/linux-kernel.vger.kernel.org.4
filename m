Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB866DB806
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDHBie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHBic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:38:32 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46458E181;
        Fri,  7 Apr 2023 18:38:31 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3380F0GO025777;
        Fri, 7 Apr 2023 18:38:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=d8PHrHGRGxHujgeyRH+zmbw9NHMOwttbGesJlcsPit4=;
 b=Qlvmske8kWNek1rMThXAYK1SeO0/W8wGy2Dv/mgrtCxRTLd/LI6tKP4pZ5ipcM4JGnuf
 QPYIXPIJUhsti1Rl/uSwH1inrkmSvW4oTklmWzVand7bEwDv2G0Ge7bU8AL99FiGNJRl
 cQ1lL2QvLUi9vX7kJJKFD7d+Cnfm81wuE3Fs1IEdV29ZW2xq24pCWRR+l9tf+MKIclO5
 mvZVBV5nwsFQfguk0JOG+0LWlaqq9agyD4ffsuccT1ZWh29bYaqon8CsWmy4vb/kC/rr
 cY9MruvLD4jo1L2NtAmp7bltRRiySOVoub1mLv5h8m2AwpWtr7Wna+Iq3tYaMAodOAAq NA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkms36q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 18:38:09 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6467E40095;
        Sat,  8 Apr 2023 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680917888; bh=d8PHrHGRGxHujgeyRH+zmbw9NHMOwttbGesJlcsPit4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=L9NJk5azQRkxOGmzLngENap8YRoJjGIuMydikCHfeaRRkkDmcU9PF+ne54Eh16QEb
         x5Y4ZFis1qje+Nte29i/F42ANrw1/CvojYMKUDffQMx+yxlAa5R+8ksaodf4KozZ80
         3mFhsxAv/wZhtcWAE5D6F3xH8IQXCOnjefNouf6RodbGweS4K22FrLHEgvdHUtiehd
         2JvTJCI1mie4EJ8bVExNVGVzgldj/Y6KtqiKUCfEhxIYfg8Ai1mfExpQTsSzMXF82S
         AonokV9iAy7aYh+032AKo7eV8lfGJmGX7rLwBCrivLuklYYK+h9xviJJJvUrd9Z6GI
         vDxkJyoMClJhA==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5D049A007A;
        Sat,  8 Apr 2023 01:38:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E6D9340074;
        Sat,  8 Apr 2023 01:38:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qgw2hVrW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJpc+coX0GjCnV9FuLrkn1RXflg4OF+Jdl/DmQ6QDcsDduaxJX0hLkatJZs8+iwbRsAKDOyxeqEZ4YjldRMRcI/IVCO+C84v98AnDvEoaJJsJHfPrYV7cIAuRXSw71VYT4s76H/TvTNtvSpbCx0Aiotj6lgfHJ+bZc7XT1iOxUF1iXAcLgDeQ90ENz3p+CuHx5pMj+gM//dMhslXcDo6uO7R0kqsCr0fd/C2LCrnOgA9uaWzIlilP65KHo8OkaqeMWOc85pa4dnDqm8QZMm3vHq0LdqAkBTQsQwfWOeNu1d1Uju+vqoy1G1WnKBzsVMmiRddXz0pxoS7riIPI4Kybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8PHrHGRGxHujgeyRH+zmbw9NHMOwttbGesJlcsPit4=;
 b=PblpftyXq/BldxU1jLXGfkNnsUC2C0q3L4yzbnckI+Fp8fjEnq9SvMpXRyVLcF/ltxw9USUpfSgcSpuT1zACCC7WCUGKDHwwj2AXth+FTuuprf/tobk6zS2WbBfLuuSedYw9N6bh9kw/nl7DMvbJ1ztG+RHzCcXLwkBri5L+b07FX67J1m+AtR9DT8jMJC5t7/j72sRmsLtXcMmdX8H7J+DXikdmVJDVUrNs+nQ9JWL7S1LhF1L3A6LJ/YxCZE91NrR+dNINt/l53zI2tumpIqW03zkvuDNlxSgMV5SZwUGAm7BWKV9iR8VqD8SJIa1WgqpbxNtnWfI0jeIklBYoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8PHrHGRGxHujgeyRH+zmbw9NHMOwttbGesJlcsPit4=;
 b=qgw2hVrWCjTsi8g9iPLK6T2fhDYWQGrzzIulZokakJlF6mczH7Go3/frM7NEsOWW4S9yfKKDQqDiEMaKV1mOgDf0Ee7Cihgk1R9OpdE2EVgVneYXxXwbiLHfS3KMOO1mpdk5l5VRapbtE8EfU7G+Z3IpzzNm986CPyDh8EYtwjA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31; Sat, 8 Apr 2023 01:38:00 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25%4]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 01:38:00 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v6 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v6 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZZ75eEvrKXHcF10y+BUBMhTPhsq8gpfyA
Date:   Sat, 8 Apr 2023 01:38:00 +0000
Message-ID: <20230408013753.x4awmbg2pzro4fqr@synopsys.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-3-quic_kriskura@quicinc.com>
In-Reply-To: <20230405125759.4201-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6544:EE_
x-ms-office365-filtering-correlation-id: 3e28d0a1-0e7d-45ba-9cb6-08db37d1e33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmOOQNkq+0ZjlTprj0NwPySjfzZTtya/eGTKEqAxfKLk1ruVMFo3enSUcqg8Ni8OSNJa3oDOqAkgWymeqfqVmTZMqnWLJKvEHLLCwXNQrSuGlBSWdXuVSGcXRBHw7M5y2Gh4/4Ug3RzvbQhvKV81IBl+gEHWW2aoOtBicraXmL9Fu0aeKKXXLcEfKFr2fBHHqJzQajGT1aOVfg1kox4IzRw+XyXRf8cB6muaBPe9QvUMFxTEL4dsz/YWqT21KcbMT77G00WMGEB2ZTISsT/ecz9MT4S+Xo0j+WoVhgNxigtPPdQtkeArRv99nLUlUEXy/FC5EmV3P6nefUVWt08Gpuab/kxeGLOufARMEUTxFOn87j/beo7F8gODGhMtbtHL82eV+S7kf1j/7TPuDDxpwYa2UxPuFL2/nk9up5F0Ne9fr/oBhArvwZnyFzZaxwqqQ6yyhO1pPmOyAEUfYzW1sgGd/eJox8JL7m4HxcdABikzEikNwUWugikBXNvMwUL7l1vK6KoaLgw+0yYytNvFsLGjrKZaNEkEvO8FV3RlwHI+UE0A5ktvskw4tjlM2/DoABBv2GFmtS86ANU6PW5SPZK1Pf/awvgeRoPg8QaivKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(83380400001)(2616005)(6486002)(966005)(478600001)(71200400001)(316002)(26005)(6506007)(54906003)(1076003)(186003)(6512007)(86362001)(2906002)(4326008)(36756003)(38100700002)(41300700001)(7416002)(6916009)(76116006)(66556008)(8676002)(122000001)(66476007)(64756008)(66946007)(38070700005)(66446008)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1JEZFRZNkQxYnZWQ2N2eUZPSGlGNHF2RzJHUURZdzJ2Zis0MkJBcmNWcndR?=
 =?utf-8?B?bkd3NmJya1ZERlFsSGg1NzgrV0dYaTFLeStCK0ozRGR6L1pzcGhXbFBYNE4w?=
 =?utf-8?B?dnEzTVBuOGM2dWJqL0Q3KzhXcVRiZm9TWmRESkxZb29zQVJiYWRrS0xDYzAy?=
 =?utf-8?B?Z3VGZDc0VWJWZVBWaFZNcGM2bkNmVkhVMGhtRnhIRjQ2aVlCRU9zZVhLbDlN?=
 =?utf-8?B?ak8vU0k0di9YQlFqYzR4cUwxY0Z1aTJqZEEyZzBGNGFBbCs5c1JrSVA0T25H?=
 =?utf-8?B?ZVNjd01MMFUzVmZRaEY4RCtTcDRLbDFSOWpYVHF2b3N4NDE3NEtLRm9YR204?=
 =?utf-8?B?MTdPeFMxcjBFbGNlNVhYaVV6ZmhJUForanVlL2tCdkpROCtpUkZjNy9ia2Fs?=
 =?utf-8?B?eEYwMS9oV3lCNnlIR1d5V0tNdjdNbzF0dVRVWVlGeGh2UTFPUGxQNXhweGk5?=
 =?utf-8?B?WmJZQVZ2VWZPV1NBZSt3SC9oRVc2am1EUUg1Uk9WVXo2TXd1ZzhuaWR1WEdw?=
 =?utf-8?B?YXJCSUpyNmlSaTBtUCtBdlMzWDFBU2QreFY1ejc1TE81bC9XWm82eVlvRGhR?=
 =?utf-8?B?c2F6R2RIbm90RFJ2NmFHZ0tiWDJiTjRVVzJlVXk0MVZxRXRCVUdxRTJNKzNI?=
 =?utf-8?B?WlBhNTFHdDREeWJYeFN5UjFRZGMrazB5Rk8ybzA0b1JuaUhqYWFRbEZDT0hj?=
 =?utf-8?B?NE5oUm1nVldoVkVLMlFJZ3N1bHpsWGhub0Jkd0pHbnBUSmtHbmVET0UySG1X?=
 =?utf-8?B?MWc0OXF1TUlhSTdweG14S3VUNEVsL2VlNnAvWG0yMDM2NldvaHZzaXAzb080?=
 =?utf-8?B?NEZGaEVybHhFUHdhckV0amRPOG5NbnRyOXM0bDRCU0hxYWI3WjJGeVpxVGIr?=
 =?utf-8?B?L2FvWTZNQ3FEbWZqU2xiR3BqVG1UWGZGL2h3VCtoWTd2Sy9MS2JtNjh4Rm9x?=
 =?utf-8?B?cWxjR1FoMHNzWHMyais3WldWZ2VNRDBRWVNkOEp2d21rR0Z4R1JrclA5RDJF?=
 =?utf-8?B?emZqWUMrYzh1Ujd5M2NxaGRXdkdSSzlYdlFoLytTdVVNU04wSHg1eUptM1N1?=
 =?utf-8?B?VnRpRGpFd2lZQ2lXbndaZFBTREI0QmQvd2RzQ0ZvMmQ0UjF5REloNTMzNE43?=
 =?utf-8?B?UDl6d2kzbFErTmRnNnZnWHc4alV3N01qbnNLTDgwOExLL0JVNUIwbU5GaWdu?=
 =?utf-8?B?NUtrQ0hnZDkzMmIwejFrR3N1dWFEZmN5VnozN2plV1ZDaU9DWjdJd3RsaGh4?=
 =?utf-8?B?enRTalNzK1FZWXlPQkNPWEphVkJ3YlZmWS9wZEZDSUlIaHJLbGZ5WUlZcmJR?=
 =?utf-8?B?ZDJlZU53bmk2V2hVWmNYNEdmdkt1YjQ3dncyU3FrSEdqRFZqSU9tdmRrZ2I5?=
 =?utf-8?B?SzhuM3JhOWNnL01tQS9yTWJuaWhkazRQN3dhVGdmUmhoUEFuOXdxUmJRYnZk?=
 =?utf-8?B?eEE2YzdxaEJmdHRoSmdiRm5WeGhwcVE4bGoycDFSTC95TUhTSFZmQW1vSnNF?=
 =?utf-8?B?WkhZTVNhNVRZamcwbCtKU0xYS1Z4Z0d1bVBUdG9hZ1RHbk9nTTFKcUs3RlZi?=
 =?utf-8?B?V0ROZmlzV3pQUU52bGhMcnZqd3NQN0RpT3pUV2tIWHkxVkRRMDJaRmpQZkNG?=
 =?utf-8?B?NkMzZUl3Wlo2aWV1RmlBZmQybkUxN3JucjNVWHU3enVkRm5RYlVFTFU2WVQy?=
 =?utf-8?B?em5QWGVkWkxuOUdPN294R3NZNGdTSkV5SGd3MmRDM2Z6eUhkOU0zZHN3S2lW?=
 =?utf-8?B?Sks3Y2puOUJIVDEzWHlYampEdVdhbG5wbDQvNG5zbE9JUHBhaVgySTd5RkFn?=
 =?utf-8?B?NWlFNVBFenByNzROM2RHYWk3TEw4ek5zT25iZTNvUXREak5rcEthZ2FmQkVK?=
 =?utf-8?B?MjhLV0lqMmNzRE51SEJndGxxL3hEWFZOQytOMDhlR0ZaTW9qN0VqRGpXMG9Y?=
 =?utf-8?B?QWhyOHF6bmZ0a214NDQwSVV4YTBaZVVBSWdmRHBNaHpLWlRXQ0RQK0dXNHk0?=
 =?utf-8?B?L1NhT29PelNPbjJHbHJEMmJVNGhHYjR0NHpzZWtJMkQ1ZUFDNkJkUXliekdr?=
 =?utf-8?B?RkJGZVFrcGhyYUVaT3ZwU2lweUJDK29PeS9wenJ4WXBLL29YYkVPeHFZQWxP?=
 =?utf-8?Q?XLKzk4ntwnggNwtIgGC5xdHHX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F12AF9DFB55FDB4DB2685508947C4078@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZlZpYWl6MTBmMTNOSW93dDIwU3FTYm1NeitSMUpEb1lPbTdydUlYZERidEVC?=
 =?utf-8?B?K29uTU1pVHdVMVM3bG5qS3ZiaVA4dTQ5eDFzSlNRajF0c2JYK0dUU01kQm1s?=
 =?utf-8?B?c0xjRk4wWlpiZnovekZibk5aL1hjb3AvRC9LbHYxUmxBclYraUsvZU5zeDVM?=
 =?utf-8?B?cDVZc2xQbEJ4ZGEydHVnUVh3VjBnb2FyNmR4UXRPM2RIUUoxb0htMnUvamxi?=
 =?utf-8?B?TW9ZR29ubFJCdis4ZWpOYkowYVRrMndaUEc0QUpGK2ttS3dRNzBBYmNBdW1U?=
 =?utf-8?B?TlhrSWdXQnFVMTBRNFZaRmtVVkp3YS9Lb3JzWG0yYlFEK3hVSHAzcEwrcWlu?=
 =?utf-8?B?SmY2TklML1hWTVB6aFF5WDNEWUE0MUljN1VvaVpEbnJpN2tQY2tBWmhYdDFZ?=
 =?utf-8?B?UVdJRWZqUUlxcGJ1V2YzSW9Ka3BRUE44bzYrYWVyRkl4emtsMnVmT3hNTTBz?=
 =?utf-8?B?TWl0VkZqMTF0YXhUQjVyQkgzbXF4WUVYY09qMFRid3RuZFgwMTI2RWJILy82?=
 =?utf-8?B?SktrcnBZSXNvU0Vzajdzc3ZUR0ZZMWNZcDAyNWlNNVRwSEhId1NXbnZ5TWsz?=
 =?utf-8?B?SG1QTVNmRFJmUlpTYzBEWU1ITnllY1J2ZG5Nck5yNWpTcXE1RExnQXNQQlJo?=
 =?utf-8?B?T2ZyR0xhOFBDY3pPdGIzelAxNkRlUzdMelR5eFIrZFhkMmVkZFJtdXFzYTNw?=
 =?utf-8?B?VTdla0g2K2NwT2xLU01uc2dEQ1dEOHJHS05HTGEzRlZaTmpsQkdRZyt6TVpl?=
 =?utf-8?B?M3NoWHZuK0FmZmJyeXFzeExhdWZPV1JEK2t2OWhMbzJqMnhrczRDTjBITlY0?=
 =?utf-8?B?amZhdDYzMllqYVJhZEtYZWhDYWIxdXFuSkNsRDBXQ2FBbFlzdmlpTXlvSlNQ?=
 =?utf-8?B?bjByZGtNd0NYMmZKdzh5K3lvakZza09OcW9DUWV0NEFmVGJPeTZrRkhMZU9R?=
 =?utf-8?B?L0s4Z0dEamtPOCswVFA4NytCeGphSFVxTFF5N2pZbUUrYUk1Q2YyendyUVlo?=
 =?utf-8?B?VytSazVpWnloVlVyS3hRcjlHN2ZnR2ZVMTc0emplWTFTamNhTFJpMW1WSXk4?=
 =?utf-8?B?U3EvbFNXMlJ1ZExkeGx3RE5BYVByaU9WTDZ0eVlHbWMrQnVDOVRDVG1jRm1T?=
 =?utf-8?B?Q2dTb1crSUNpS3dvVldRVGJ5L09veGtDYUdPZGV1UURxMEFDZGJnTGVBS3lI?=
 =?utf-8?B?b1hTVmlubGcwbGtBaVNORzJ0cVJKSzcvMTdBUjB5b2YvaHlSUHA0ZmpPZURw?=
 =?utf-8?B?UDlmcmswdURPS0FHQzlNOTkzbHNmY2wvVHFSZWdzTGtEWDJvbDZCdUR1TjVk?=
 =?utf-8?B?MVVDTzdKbnI3aWFVSlZuazYyc2pMRGNPWUJkMllQdnBmSVpjNmtVZExVMW1p?=
 =?utf-8?B?OXo0T3NFVkR3bWc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e28d0a1-0e7d-45ba-9cb6-08db37d1e33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 01:38:00.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBcCLtrEaBnFHYUYgv4SX/VcuKqfcOAZFtFaIy44KNIVl7NWe4c5f9TYKkXMRF3IM72JjjijSaI1CDqwrUBUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
X-Proofpoint-ORIG-GUID: GEzDqpdvsWA2sHbC6HpOyWP7fpSnDN06
X-Proofpoint-GUID: GEzDqpdvsWA2sHbC6HpOyWP7fpSnDN06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304080013
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMDUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBob3N0LW9ubHkgY2FwYWJsZSBEV0MzIGNvbnRyb2xsZXJzIHN1cHBvcnQgTXVsdGlwb3J0LiBU
ZW1wb3JhcmlseQ0KPiBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9ubHkgY29udHJv
bGxlcnMgYW5kIHBhcnNlIFhIQ0kgRXh0ZW5kZWQNCj4gQ2FwYWJpbGl0aWVzIHJlZ2lzdGVycyB0
byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZCB1c2IzIHBvcnRzIHByZXNlbnQgb24NCj4g
bXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXRsZWFzdCBIUyBjYXBhYmxl
Lg0KPiANCj4gVGhlIHBvcnQgaW5mbyBmb3IgdXNiMiBhbmQgdXNiMyBwaHkgYXJlIGlkZW50aWZp
ZWQgYXMgbnVtX3VzYjJfcG9ydHMgYW5kDQo+IG51bV91c2IzX3BvcnRzLiBUaGUgaW50ZW50aW9u
IGlzIGFzIGZvbGxvd3M6DQo+IA0KPiBXaGVyZXZlciB3ZSBuZWVkIHRvIHBlcmZvcm0gcGh5IG9w
ZXJhdGlvbnMgbGlrZToNCj4gDQo+IExPT1BfT1ZFUl9OVU1CRVJfT0ZfQVZBSUxBQkxFX1BPUlRT
KCkNCj4gew0KPiAJcGh5X3NldF9tb2RlKGR3Yy0+dXNiMl9nZW5lcmljX3BoeVtpXSwgUEhZX01P
REVfVVNCX0hPU1QpOw0KPiAJcGh5X3NldF9tb2RlKGR3Yy0+dXNiM19nZW5lcmljX3BoeVtpXSwg
UEhZX01PREVfVVNCX0hPU1QpOw0KPiB9DQo+IA0KPiBJZiBudW1iZXIgb2YgdXNiMiBwb3J0cyBp
cyAzLCBsb29wIGNhbiBnbyBmcm9tIGluZGV4IDAtMiBmb3IgdXNiMl9nZW5lcmljX3BoeS4NCj4g
SWYgbnVtYmVyIG9mIHVzYjMtcG9ydHMgaXMgMiwgd2UgZG9uJ3Qga25vdyBmb3Igc3VyZSwgaWYg
dGhlIGZpcnN0IDIgcG9ydHMgYXJlDQo+IFNTIGNhcGFibGUgb3Igc29tZSBvdGhlciBwb3J0cyBs
aWtlICgyIGFuZCAzKSBhcmUgU1MgY2FwYWJsZS4gU28gaW5zdGVhZCwNCj4gbnVtX3VzYjJfcG9y
dHMgaXMgdXNlZCB0byBsb29wIGFyb3VuZCBhbGwgcGh5J3MgKGJvdGggaHMgYW5kIHNzKSBmb3IN
Cj4gcGVyZm9ybWluZyBwaHkgb3BlcmF0aW9ucy4gSWYgYW55IHVzYjNfZ2VuZXJpY19waHkgdHVy
bnMgb3V0IHRvIGJlIE5VTEwsIHBoeQ0KPiBvcGVyYXRpb24ganVzdCBiYWlscyBvdXQuDQo+IA0K
PiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRvIG1vZGlmeSBHVVNCM1BJUEVDVEwgcmVnaXN0ZXJz
IHdoaWxlIHNldHRpbmcgdXANCj4gcGh5J3MgYXMgd2UgbmVlZCB0byBrbm93IGhvdyBtYW55IFNT
IGNhcGFibGUgcG9ydHMgYXJlIHRoZXJlIGZvciB0aGlzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+IExp
bmsgdG8gdjU6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMzAzMTAxNjM0MjAuNzU4Mi0zLXF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20v
X187ISFBNEYyUjlHX3BnIWVYYUtKZWpyVDA1M01fNmFmNDZtQzhqanlCbWRaQkJoSjBiVktseXhG
aUlNUl9WMVJ3bEJzXzlWZHZYaHBKdU5CREhpMGQ4a2RaRHJJME1kRktuS0E2VkEwaTZGd3ckIA0K
PiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNjkgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgNjAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTI5
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDQ3NmI2MzYxODUxMS4uNTY3YWU3
OTM4OWExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTc1MCw2ICsxNzUwLDYwIEBAIHN0YXRpYyBz
dHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJ
cmV0dXJuIGVkZXY7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19yZWFkX3BvcnRfaW5m
byhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ICsJ
dTMyCQkJb2Zmc2V0Ow0KPiArCXUzMgkJCXRlbXA7DQo+ICsJdTgJCQltYWpvcl9yZXZpc2lvbjsN
Cj4gKwlpbnQJCQlyZXQgPSAwOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBSZW1hcCB4SENJIGFkZHJl
c3Mgc3BhY2UgdG8gYWNjZXNzIFhIQ0kgZXh0IGNhcCByZWdzLA0KPiArCSAqIHNpbmNlIGl0IGlz
IG5lZWRlZCB0byBnZXQgcG9ydCBpbmZvLg0KPiArCSAqLw0KPiArCXJlZ3MgPSBpb3JlbWFwKGR3
Yy0+eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsDQo+ICsJCQkJcmVzb3VyY2Vfc2l6ZSgmZHdjLT54
aGNpX3Jlc291cmNlc1swXSkpOw0KPiArCWlmIChJU19FUlIocmVncykpIHsNCj4gKwkJcmV0dXJu
IFBUUl9FUlIocmVncyk7DQo+ICsJfQ0KPiArDQo+ICsJb2Zmc2V0ID0gZHdjM194aGNpX2ZpbmRf
bmV4dF9leHRfY2FwKHJlZ3MsIDAsDQo+ICsJCQkJCVhIQ0lfRVhUX0NBUFNfUFJPVE9DT0wpOw0K
PiArCXdoaWxlIChvZmZzZXQpIHsNCj4gKwkJdGVtcCA9IHJlYWRsKHJlZ3MgKyBvZmZzZXQpOw0K
PiArCQltYWpvcl9yZXZpc2lvbiA9IFhIQ0lfRVhUX1BPUlRfTUFKT1IodGVtcCk7Ow0KPiArDQo+
ICsJCXRlbXAgPSByZWFkbChyZWdzICsgb2Zmc2V0ICsgMHgwOCk7DQo+ICsJCWlmIChtYWpvcl9y
ZXZpc2lvbiA9PSAweDAzKSB7DQo+ICsJCQlkd2MtPm51bV91c2IzX3BvcnRzICs9IFhIQ0lfRVhU
X1BPUlRfQ09VTlQodGVtcCk7DQo+ICsJCX0gZWxzZSBpZiAobWFqb3JfcmV2aXNpb24gPD0gMHgw
Mikgew0KPiArCQkJZHdjLT5udW1fdXNiMl9wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NPVU5UKHRl
bXApOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJZGV2X2Vycihkd2MtPmRldiwgInBvcnQgcmV2aXNp
b24gc2VlbXMgd3JvbmdcbiIpOw0KPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gKwkJCWdvdG8gdW5t
YXBfcmVnOw0KPiArCQl9DQo+ICsNCj4gKwkJb2Zmc2V0ID0gZHdjM194aGNpX2ZpbmRfbmV4dF9l
eHRfY2FwKHJlZ3MsIG9mZnNldCwNCj4gKwkJCQkJCVhIQ0lfRVhUX0NBUFNfUFJPVE9DT0wpOw0K
PiArCX0NCj4gKw0KPiArCXRlbXAgPSByZWFkbChyZWdzICsgRFdDM19YSENJX0hDU1BBUkFNUzEp
Ow0KPiArCWlmIChIQ1NfTUFYX1BPUlRTKHRlbXApICE9IChkd2MtPm51bV91c2IzX3BvcnRzICsg
ZHdjLT5udW1fdXNiMl9wb3J0cykpIHsNCj4gKwkJZGV2X2Vycihkd2MtPmRldiwgImluY29uc2lz
dGVuY3kgaW4gcG9ydCBpbmZvXG4iKTsNCj4gKwkJcmV0ID0gLUVJTlZBTDsNCj4gKwkJZ290byB1
bm1hcF9yZWc7DQo+ICsJfQ0KPiArDQo+ICsJZGV2X2RiZyhkd2MtPmRldiwNCj4gKwkJImhzLXBv
cnRzOiAlZCBzcy1wb3J0czogJWRcbiIsIGR3Yy0+bnVtX3VzYjJfcG9ydHMsIGR3Yy0+bnVtX3Vz
YjNfcG9ydHMpOw0KPiArDQo+ICt1bm1hcF9yZWc6DQo+ICsJaW91bm1hcChyZWdzKTsNCj4gKwly
ZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0gJnBk
ZXYtPmRldjsNCj4gQEAgLTE3NTcsNiArMTgxMSw3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXN0cnVjdCBkd2MzCQkqZHdjOw0KPiAg
DQo+ICAJaW50CQkJcmV0Ow0KPiArCXVuc2lnbmVkIGludAkJaHdfbW9kZTsNCj4gIA0KPiAgCXZv
aWQgX19pb21lbQkJKnJlZ3M7DQo+ICANCj4gQEAgLTE4ODAsNiArMTkzNSwyMCBAQCBzdGF0aWMg
aW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCWdvdG8g
ZGlzYWJsZV9jbGtzOw0KPiAgCX0NCj4gIA0KPiArCS8qDQo+ICsJICogQ3VycmVudGx5IERXQzMg
Y29udHJvbGxlcnMgdGhhdCBhcmUgaG9zdC1vbmx5IGNhcGFibGUNCj4gKwkgKiBzdXBwb3J0IE11
bHRpcG9ydA0KPiArCSAqLw0KPiArCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2Mt
Pmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ICsJaWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMw
X01PREVfSE9TVCkgew0KPiArCQlyZXQgPSBkd2MzX3JlYWRfcG9ydF9pbmZvKGR3Yyk7DQo+ICsJ
CWlmIChyZXQpDQo+ICsJCQlnb3RvIGRpc2FibGVfY2xrczsNCj4gKwl9IGVsc2Ugew0KPiArCQlk
d2MtPm51bV91c2IyX3BvcnRzID0gMTsNCj4gKwkJZHdjLT5udW1fdXNiM19wb3J0cyA9IDE7DQo+
ICsJfQ0KPiArDQo+ICAJc3Bpbl9sb2NrX2luaXQoJmR3Yy0+bG9jayk7DQo+ICAJbXV0ZXhfaW5p
dCgmZHdjLT5tdXRleCk7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNDc0M2U5MThkY2FmLi4yMjli
N2RhOGM1YmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0zNSw2ICszNSwxNyBAQA0KPiAgDQo+ICAj
ZGVmaW5lIERXQzNfTVNHX01BWAk1MDANCj4gIA0KPiArLyogRGVmaW5lIFhIQ0kgRXh0Y2FwIHJl
Z2lzdGVyIG9mZnNldHMgZm9yIGdldHRpbmcgbXVsdGlwb3J0IGluZm8gKi8NCj4gKyNkZWZpbmUg
WEhDSV9IQ0NfUEFSQU1TX09GRlNFVCAgMHgxMA0KPiArI2RlZmluZSBEV0MzX1hIQ0lfSENTUEFS
QU1TMSAgIDB4MDQNCj4gKyNkZWZpbmUgWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCAgMg0KPiArI2Rl
ZmluZSBYSENJX0hDQ19FWFRfQ0FQUyhwKSAgICAoKChwKT4+MTYpJjB4ZmZmZikNCj4gKyNkZWZp
bmUgWEhDSV9FWFRfQ0FQU19JRChwKSAgICAgKCgocCk+PjApJjB4ZmYpDQo+ICsjZGVmaW5lIFhI
Q0lfRVhUX0NBUFNfTkVYVChwKSAgICgoKHApPj44KSYweGZmKQ0KDQpGaXggdGhlc2Ugc3BhY2lu
ZyBhbmQgbmFtaW5nIGluY29uc2lzdGVuY3kgKHggdnMgcCkuDQoNCj4gKyNkZWZpbmUgWEhDSV9F
WFRfUE9SVF9NQUpPUih4KSAgKCgoeCkgPj4gMjQpICYgMHhmZikNCj4gKyNkZWZpbmUgWEhDSV9F
WFRfUE9SVF9DT1VOVCh4KSAgKCgoeCkgPj4gOCkgJiAweGZmKQ0KPiArI2RlZmluZSBIQ1NfTUFY
X1BPUlRTKHApICAgICAgICAoKChwKSA+PiAyNCkgJiAweDdmKQ0KPiArDQo+ICAvKiBHbG9iYWwg
Y29uc3RhbnRzICovDQo+ICAjZGVmaW5lIERXQzNfUFVMTF9VUF9USU1FT1VUCTUwMAkvKiBtcyAq
Lw0KPiAgI2RlZmluZSBEV0MzX0JPVU5DRV9TSVpFCTEwMjQJLyogc2l6ZSBvZiBhIHN1cGVyc3Bl
ZWQgYnVsayAqLw0KPiBAQCAtMTAyMyw2ICsxMDM0LDEwIEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hw
YWRfYXJyYXkgew0KPiAgICogQHVzYl9wc3k6IHBvaW50ZXIgdG8gcG93ZXIgc3VwcGx5IGludGVy
ZmFjZS4NCj4gICAqIEB1c2IyX3BoeTogcG9pbnRlciB0byBVU0IyIFBIWQ0KPiAgICogQHVzYjNf
cGh5OiBwb2ludGVyIHRvIFVTQjMgUEhZDQo+ICsgKiBAbnVtX3VzYjJfcG9ydHM6IEluZGljYXRl
cyB0aGUgbnVtYmVyIG9mIHVzYjIgcG9ydHMgdG8gYmUgc2VydmljZWQgYnkgdGhlDQo+ICsgKgkJ
CWNvbnRyb2xsZXIuDQoNCkNhbiB3ZSBqdXN0IHNheSAibnVtYmVyIG9mIHVzYjIgcG9ydHMiLg0K
DQo+ICsgKiBAbnVtX3VzYjNfcG9ydHM6IEluZGljYXRlcyB0aGUgbnVtYmVyIG9mIHVzYjMgcG9y
dHMgdG8gYmUgc2VydmljZWQgYnkgdGhlDQo+ICsgKgkJCWNvbnRyb2xsZXIuDQo+ICAgKiBAdXNi
Ml9nZW5lcmljX3BoeTogcG9pbnRlciB0byBVU0IyIFBIWQ0KPiAgICogQHVzYjNfZ2VuZXJpY19w
aHk6IHBvaW50ZXIgdG8gVVNCMyBQSFkNCj4gICAqIEBwaHlzX3JlYWR5OiBmbGFnIHRvIGluZGlj
YXRlIHRoYXQgUEhZcyBhcmUgcmVhZHkNCj4gQEAgLTExNTgsNiArMTE3Myw4IEBAIHN0cnVjdCBk
d2MzIHsNCj4gIAlzdHJ1Y3QgdXNiX3BoeQkJKnVzYjJfcGh5Ow0KPiAgCXN0cnVjdCB1c2JfcGh5
CQkqdXNiM19waHk7DQo+ICANCj4gKwl1MzIJCQludW1fdXNiMl9wb3J0czsNCj4gKwl1MzIJCQlu
dW1fdXNiM19wb3J0czsNCj4gIAlzdHJ1Y3QgcGh5CQkqdXNiMl9nZW5lcmljX3BoeTsNCj4gIAlz
dHJ1Y3QgcGh5CQkqdXNiM19nZW5lcmljX3BoeTsNCj4gIA0KPiBAQCAtMTY0NSw0ICsxNjYyLDQ3
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX3VscGlfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgeyB9DQo+ICAjZW5kaWYNCj4gIA0KPiArLyoqDQo+ICsgKiBGaW5kIHRoZSBvZmZzZXQgb2Yg
dGhlIGV4dGVuZGVkIGNhcGFiaWxpdGllcyB3aXRoIGNhcGFiaWxpdHkgSUQgaWQuDQo+ICsgKg0K
PiArICogQGJhc2UJUENJIE1NSU8gcmVnaXN0ZXJzIGJhc2UgYWRkcmVzcy4NCj4gKyAqIEBzdGFy
dAlhZGRyZXNzIGF0IHdoaWNoIHRvIHN0YXJ0IGxvb2tpbmcsICgwIG9yIEhDQ19QQVJBTVMgdG8g
c3RhcnQgYXQNCj4gKyAqCQliZWdpbm5pbmcgb2YgbGlzdCkNCj4gKyAqIEBpZAkJRXh0ZW5kZWQg
Y2FwYWJpbGl0eSBJRCB0byBzZWFyY2ggZm9yLCBvciAwIGZvciB0aGUgbmV4dA0KPiArICoJCWNh
cGFiaWxpdHkNCj4gKyAqDQo+ICsgKiBSZXR1cm5zIHRoZSBvZmZzZXQgb2YgdGhlIG5leHQgbWF0
Y2hpbmcgZXh0ZW5kZWQgY2FwYWJpbGl0eSBzdHJ1Y3R1cmUuDQo+ICsgKiBTb21lIGNhcGFiaWxp
dGllcyBjYW4gb2NjdXIgc2V2ZXJhbCB0aW1lcywgZS5nLiwgdGhlIFhIQ0lfRVhUX0NBUFNfUFJP
VE9DT0wsDQo+ICsgKiBhbmQgdGhpcyBwcm92aWRlcyBhIHdheSB0byBmaW5kIHRoZW0gYWxsLg0K
PiArICovDQoNCkRvY3VtZW50YXRpb24gc3R5bGUgaXMgZGlmZmVyZW50Pw0KDQo+ICsNCj4gK3N0
YXRpYyBpbmxpbmUgaW50IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcCh2b2lkIF9faW9tZW0g
KmJhc2UsIHUzMiBzdGFydCwgaW50IGlkKQ0KPiArew0KPiArCXUzMiB2YWw7DQo+ICsJdTMyIG5l
eHQ7DQo+ICsJdTMyIG9mZnNldDsNCj4gKw0KPiArCW9mZnNldCA9IHN0YXJ0Ow0KPiArCWlmICgh
c3RhcnQgfHwgc3RhcnQgPT0gWEhDSV9IQ0NfUEFSQU1TX09GRlNFVCkgew0KPiArCQl2YWwgPSBy
ZWFkbChiYXNlICsgWEhDSV9IQ0NfUEFSQU1TX09GRlNFVCk7DQo+ICsJCWlmICh2YWwgPT0gfjAp
DQo+ICsJCQlyZXR1cm4gMDsNCj4gKwkJb2Zmc2V0ID0gWEhDSV9IQ0NfRVhUX0NBUFModmFsKSA8
PCAyOw0KPiArCQlpZiAoIW9mZnNldCkNCj4gKwkJCXJldHVybiAwOw0KPiArCX0NCj4gKwlkbyB7
DQo+ICsJCXZhbCA9IHJlYWRsKGJhc2UgKyBvZmZzZXQpOw0KPiArCQlpZiAodmFsID09IH4wKQ0K
PiArCQkJcmV0dXJuIDA7DQo+ICsJCWlmIChvZmZzZXQgIT0gc3RhcnQgJiYgKGlkID09IDAgfHwg
WEhDSV9FWFRfQ0FQU19JRCh2YWwpID09IGlkKSkNCj4gKwkJCXJldHVybiBvZmZzZXQ7DQo+ICsN
Cj4gKwkJbmV4dCA9IFhIQ0lfRVhUX0NBUFNfTkVYVCh2YWwpOw0KPiArCQlvZmZzZXQgKz0gbmV4
dCA8PCAyOw0KPiArCX0gd2hpbGUgKG5leHQpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+
ICsNCj4gICNlbmRpZiAvKiBfX0RSSVZFUlNfVVNCX0RXQzNfQ09SRV9IICovDQo+IC0tIA0KPiAy
LjQwLjANCj4gDQoNCk15IGNoZWNrcGF0Y2ggcmVwb3J0cyBzb21lIGVycm9ycy4gQ2FuIHlvdSBj
aGVjaz8NCg0KVGhhbmtzLA0KVGhpbmg=
