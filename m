Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C86D55BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjDDBLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDDBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:11:27 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0FA213F;
        Mon,  3 Apr 2023 18:11:26 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333LVeNx003785;
        Mon, 3 Apr 2023 18:11:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=H8MAf8eCn3sGq2DaZIsnp70PvJ4Y7fIgpry88tFWGP8=;
 b=BggMJCqszDap2LKWWczmeMuVVYT9C5aJU384zomSurNB4RYn9BsbOF62ZwmoVaTK9/9I
 RLfqTlPwiK4T00+xAak8WVO4zFZSGtkrFOq0wq5orKXRHiybeowABLhleGDIMnNQfw4X
 GiUz90hhb2ldsaK3y6HXscBKWOAzeQDtIhHvrjPKOKaYWcDxz9lranotbQVXzPNXhHgP
 AgpFaSWeGp2HM2UafnA36y+ps1l8fBX59gldUHH/0alEfOJxWxT7tnl8f8DYYaV1DHAv
 lteyeoS4Ln5Qyyjy5p0S2nUYq7uT9EKb3PJkN6am9413lq6s9HwzhuzPvS2W0Q5Z1WXL Mg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhxbwj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:11:23 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6E06740099;
        Tue,  4 Apr 2023 01:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680570682; bh=H8MAf8eCn3sGq2DaZIsnp70PvJ4Y7fIgpry88tFWGP8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MvmD9LznKwtGxAzAyX8K2IpfH2FpmalsCF4iV0ANTdCC1pOlvDWV17ze+d8VIsXMF
         MR53fJMBUQf/J2Y/yXlQa24Uy9Dny0tE60iMWOEcIZODE8bYKTu9dC1FTrhecDIkfB
         kJWYIlSuAeloyHklivSjg0wrC85xHPBfZ+cx12s+zktK4Y0wbQq8D0V7V3cQFJfRFZ
         GsZRFWqVVOHrVsdO9x3/547FAw1kaH2G6lVY7ZUBKvyKUTzCjXsiF3SjYJdUvXKp/K
         OsTr/5RZfb82G7No7XuwoMwiqXPMzCZr+bfx77xCcBts+Hc3zcpZizs1LvA15J8V54
         mY3035gnKxgag==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 99B31A0079;
        Tue,  4 Apr 2023 01:11:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0791A4006A;
        Tue,  4 Apr 2023 01:11:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Fh31ErVE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpneG3wWlLVS4TMLnUHMGsAM5TIjfSLtoDnunEEPYy8ZvwvAu7eZ+WeheiIQUhF4h3jlG3Sf3xcEDyds0PhunRLSx+T6wGFzo5CdrttcGC5awFG1Sz5dtgT5hOOXOoTfZey9MvjAlQQu3jqyqo0nb3MNkCkvi8JL9/8anND+PKsLjiKRnV+wYDBQNuxMACGXVhLhjcM9T41R2i0hgv4rAGyDiZhxWgs8D46bWfYm9mSj/B68v+H0qsnmn/gNTu8Yz9WrT7H0mJgJL5hKdZnc4A8dH+mDXRo7kSNCfcHdXs3SaXQz5HURhmOxsWaTnDyExSdPAEK/X/4RAipPImCB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8MAf8eCn3sGq2DaZIsnp70PvJ4Y7fIgpry88tFWGP8=;
 b=iAlv6s1ZVJ2jyub7mU7EmOrfAzuDnczN0/kXOJoXepeCesPm1yNMfDxtjSLa8DCyGmP5aw88NzPVoivxc7RJkR5JXn5ocWo+pdQu1IuBkMLrJMNSyQQDkrNsLuJDj40PX4Z/4yL94Ky7pc5bX+FPaGMbbSYu9XSdOjzxU/z6yJo2qH90P1H/fZWCfYLqj1XoHGTNT3jf/M4homuhBR3WflcFxD7S49ifkPrxl+weft1JIgTrspkWUfxwOmB/fgAn2+beFb816smgV6dCcS4nrjTFA0nx5lP3sa6k2ed9GcDU6SazXiA2o69qWgxvL9gC+n3A6K3z8JG8qRhMbLMMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8MAf8eCn3sGq2DaZIsnp70PvJ4Y7fIgpry88tFWGP8=;
 b=Fh31ErVEpx8MNZMxxszKsdPWCJQUX0DEUvBZySHtjva7JfOkab1bi7XiBiwVb2U2ne+65zluQVQH9tkUWiu7P+KdwzCW7z30aEkhvxNdtRDWF7uXgXwix29RpwPdNyDrnVIN1fKqoWWpQw3Dd+8Zj7ItPMo3G7oortufLb8q86s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 01:11:13 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 01:11:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Thread-Topic: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Thread-Index: AQHZZCdzfLLJh52qvUySQjzgywjsKK8aXF0A
Date:   Tue, 4 Apr 2023 01:11:13 +0000
Message-ID: <20230404011108.727htmnllj7ojwqm@synopsys.com>
References: <20230331232039.1407-1-quic_wcheng@quicinc.com>
In-Reply-To: <20230331232039.1407-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB7496:EE_
x-ms-office365-filtering-correlation-id: 4b7de6b9-31f5-4a5b-fbb5-08db34a97ba1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +d0rxmdvylrEDVwD8iXJXaYcf+7h/66u/dIYD4RX8DYBuiVe+MgeMW0JynZMibFcbgK0/DC0m4MfEGsXAV4CyZCObc6kpBZm3YrDvRG9ue1BEetv9MvaL/8pokumPsqQ4do/JeDXevocpkinWS2jLBNPSCWdG6GC78i8m/WgQmVZPCU8PuYGnz2Ha6eY4fDE5fjKGv6lPlKvn4ioZEINfYQ7dNjYDdyXNc9/ptu5kU6SHf0NV1snuFTaovO///IsqVxUOlujHcXHnWQ5EvoNfwuWNj0Bf8uDAXoPydgG5s4WzJxp9TR97ixpRv3fusDVhmzTZveY1/BjzMl0OWqU/gkhF3EIfTfpUl2jML9fAZVuB/T7UQsaY8VrZed1FYvctlavq2Uk2nfxtqZ7kPLUENk/gnsVeDLxtbvPogFNBQ0JGQRPTOLOR8yxmIYx2VRJSoQAmdSBwhvp+PlLMn0FsdSf6+HTSmAwde93i2InrVw/cPlJE5flhfkr4aq0YtzhkYPod33Og0x2XXqL0AoXAeyhS1umxepPRSboAJdfOXaRn6rTIorWORF4DP+23P1EBGnquTpfjbzZ568EvI7w4ngmVctWhc7ydHudAvovls4YFXyMLWfKxkMWrbZvgLNBS3QBPlHyZ6QeQfqpb21hoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(8676002)(66476007)(6916009)(66556008)(478600001)(66446008)(5660300002)(41300700001)(66946007)(54906003)(316002)(8936002)(2906002)(186003)(64756008)(6512007)(6486002)(26005)(1076003)(76116006)(4326008)(6506007)(83380400001)(2616005)(122000001)(38100700002)(38070700005)(86362001)(71200400001)(36756003)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUtJck9ycmk4MnRTeEpUcWwzd2tLL2plSmROZWlpTjB0RmtaSExUVlhpMFNC?=
 =?utf-8?B?NU5hbkVEUEJTblZhbjE0dnZYdzMxeGhncmVacDlTaVczREd2a0RkcE1HT1lO?=
 =?utf-8?B?QlAxVmtscERmRG1PcHhmTVB5b0ppckc1WTJ6ZDNkbU42MTE5L25XVDJRUTVp?=
 =?utf-8?B?V1hYTHRSdFJqb3NXd21WT0ljbm9Dc1gzcTFDcGF6QmFYS0NvMVVnUnhzckY0?=
 =?utf-8?B?cnBVLzNjSnhhWlUySTVpWjcyc3BnU0NJd2JndjRIOWpBVHVkQlI5Y2VUUG16?=
 =?utf-8?B?cnh3cytpTmJRTXQ1dmtPM1psckYwZWxWdzR6eDkyUmFOYWZqSEwvVTNwZFAv?=
 =?utf-8?B?aXQzOXB5UDRPVmFHQTRCNFhTTlpsc01mc0l0ektlL2s2UzJsNXUzS2dtMzhJ?=
 =?utf-8?B?WHAzb1Z1Q04yVEs3cW5jUmUvWjI3TFQvVm5lV2w3dlhDenZPa2w4b1V3TCtp?=
 =?utf-8?B?U1k4a1hqdUVrZEJzYnBSYmRsTVArcUJraWpMM3VwMFRGVUVpQUZGRE1ERHhJ?=
 =?utf-8?B?b1lmU2VWdXl3emZGcHZ0b0xxekVaekRCakdtR1BHOVpjd0lqVzgvZVRKa1oz?=
 =?utf-8?B?c3VTQk1qY2wwcUNxb3M0SDB6bXgwUVNpa1ZnQjhNTFB4ekt2cmVCb0FEdE1m?=
 =?utf-8?B?QmRtSDl0REN2aUFiVmU5TlIrTU1kcWhHT2VORThwNDV0c2cyK2sySjRSaHRh?=
 =?utf-8?B?YVJ6NUhnL0RlUm1PbC9xNGp3dFNKQW9wSFRhNHYyTDF1V3N4THY0b0ZadFMr?=
 =?utf-8?B?bktWejlNZUNVOXM0V2t2QzJWQURBOGNRVTRtbElZbnFmY3hTelVaT250aEdR?=
 =?utf-8?B?Qzd4b2JFYU1ueTlwRlFEdm1paC9zREQrSXNGWUZyWk1LZUl1NTFrRnlNZ0hD?=
 =?utf-8?B?K1ZIZS9NbU54ZndSTEdZaDN4blZZbURiNzYrMGRPT1JHa1VRUmR2VmpkS3RY?=
 =?utf-8?B?MnZHRll4YUxrNUpFc01oaDJtc2dVT1hZakxnb0dQVlRwOG8zS2Y3Q0RZdnZH?=
 =?utf-8?B?OHJleFppTElzWENpUlZua0JQZEV5OGhqU3hiSCtnTjhuR3pHL2gyYzIyaXVj?=
 =?utf-8?B?c0NSUUoxQWwzVHNsUEdCZlJhRklQMWxpUGh1QlBGdEk2VXpNc3RkczNDMDNR?=
 =?utf-8?B?YThmTCtzUnlhZWlVRFJxeHd1azZYRTJZRXk5UXVBQjFLVEJUejlGd3hRUGpr?=
 =?utf-8?B?YUxSOWVlS01aNkR1WDZWMUlVeXJPSTNPL29OVytBRUxwUmR4bWY2UEJjTk9s?=
 =?utf-8?B?WHA3UEM4bWhPeTN3Vk04eGlBY2ZqOW1BSlFteERnQXh4OUh3bUc4TzBnZ1Ir?=
 =?utf-8?B?MDZYNFBIZmlNRHZUdm05YUxnZUJGcnQ3OExENHNPaDZ5cWpkQVkxTDZDb041?=
 =?utf-8?B?OExGZGdCS2pvNWVHeHEyWm5QZGdrbExRd3ZyanFPd0xvNEEwK2NoaHFRYTBR?=
 =?utf-8?B?U0t1b1RXVTJJbTRocko3ZzRiMzZORkJiSnhMTnVNOURHTWV1WXdhNXp1bGVj?=
 =?utf-8?B?bmdtQWltaDJHRHVmMEhjdWJ4NFBGVnllT3VJd2IweGU0SkU2YTd0WUhnYzJu?=
 =?utf-8?B?eGszUGdETHJNaVl4TGN6RHM2Yk9ieU84aGhjMHNLWWhsQ0pzL0EvT1o0ejY3?=
 =?utf-8?B?ZFZvVm5VVEpNWFJTaldnakNRcGNXZjRIbTRJV1VrUTkvdHFwWlpaaU04WDRt?=
 =?utf-8?B?d3NXUXJFM205ckxyZDlTVEdHMnBZTVZyZG9qM2hMY0NzZ2kwVzQ3QjRIYlBM?=
 =?utf-8?B?R0RvVm8zdjZIYU5saGIxNFU5clhJWEJrdk5tWHY3SVN2cEpYeHdsN1ZUdzQ5?=
 =?utf-8?B?SUd0TWpKc1ZVbjJCTk1HcmlJc3RzQTJSYTBqZlVQNUVGSkE3cHcvaDBNK3ls?=
 =?utf-8?B?a1Q4VURGaGMzMTBNTGQ4Qjg4d0ZBbnVnSkI0M0QyVTZyL0hsT2ZjMlB4a3Vi?=
 =?utf-8?B?V2FoOXBZcEhWTStJeVIxaWhUa1BiYkpKdUU5Yk5Ya2k2bDdyT0hRUHJMU0Fw?=
 =?utf-8?B?TzdoTEcrS25UZEJXZEVISWozTkJQZ1E1VHlOR0xocUh2dVpybVpoU0J3WWpy?=
 =?utf-8?B?TjQ5b3RPMVF1b2xwL3I0WFpUUm1GaVpISFRid1FjOHgraXZsdFJBcWVaQkdk?=
 =?utf-8?Q?bs0cnlZkl6/475wUqEavDxFcY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B181EE7BDE13374283D25332F8CB5334@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VBkpsV/cwzCN0UvD5hgwV4+VZKV7qjmbmT5YFL4tcRa/rh8kfsJUcNHh5V9DdMomAYn2yF5rTRdhshjXCNK0M/ikOom0v+OB7jYRGW5pBasoJZ3EjtZ6q91jbTlvec7zpHBL2CoVQSHeMXNX5GCXYyKMIXUpvogX/cYanlA7nACY5+Kv43thcrKkdwGfbF1Tyx3nh50pcOERRRqi11QW122mdo9cbrFvGyyc8AKx1FB8D9GM8L+6BBQaFXTzaEJy5fMCKi28Dp88boKm5URtBQErC5EqW5fxDKn4HZyt9tSjsyFM4lP3l2BHWX6ViYbQzPXz7CfLVDbf+vn+HL6RJbixL9F+AvGC6u3ZEpevge0ZsHJ9Lojf9oHoLui4b0JgQNd1kRk1Kvok1WTqitgKtLEfAJnWIogwaG+90l8eXy2e6BlpQSlu1cGQeBIVYdDe2bw7rtdj1vz6oqkmHxPCvGzJ8AxYqfBOLJhJuvJeBvPdAPuhLUo8QNJRI5fE9n2AX/dN5mdDzu/wcsGIuFIVHUC9l+DrrUh4UaAxclUKA8hE8jaoZqyi+BvDv8CF3NQSKxFzNYUfcr6zLYiPqwGchEIAj88URWl30lCPKb+o5QpPE3RQ+xW23BdwSpqVhP64tJsy/CI/TZT7eIQy2XdHgkthYFDeh9Dw0Y1JUqHHBvJd6UIwc/XdAYQSOl93xIlZC9oAp3lWOKzbCJWd02lFM42zVifqm8JeH7Tx2eVwZfPn9kv+8fAMxHCKfpvQeGfpdUwykG9R7xxnEVg+/ty5W0qQueulVycTiHsPhy/sGvnYJFNi930oKluEKSEFXuM1O4alqPXopYVzyM7uvLI0yYNg5C4iwL37Q409rqumHQ68CASgJKuDFiC7+7VCq4lo
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7de6b9-31f5-4a5b-fbb5-08db34a97ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 01:11:13.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxpDH7VfS0xNWNj31FfnqKgu+kaUzjdq34rsgOxEtxaLgAHY1kP7h9iQZ25NDpQeFVX/gZwCqaodHCN7kPqnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
X-Proofpoint-GUID: rb4Vy205p1FqY8rqjL1kHm_PoMCMIOXR
X-Proofpoint-ORIG-GUID: rb4Vy205p1FqY8rqjL1kHm_PoMCMIOXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040010
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMzEsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSXQgd2FzIG9ic2Vy
dmVkIHRoYXQgdGhlcmUgYXJlIGhvc3RzIHRoYXQgbWF5IGNvbXBsZXRlIHBlbmRpbmcgU0VUVVAN
Cj4gdHJhbnNhY3Rpb25zIGJlZm9yZSB0aGUgc3RvcCBhY3RpdmUgdHJhbnNmZXJzIGFuZCBjb250
cm9sbGVyIGhhbHQgb2NjdXJzLA0KPiBsZWFkaW5nIHRvIGxpbmdlcmluZyBlbmR4ZmVyIGNvbW1h
bmRzIG9uIERFUHMgb24gc3Vic2VxdWVudCBwdWxsdXAvZ2FkZ2V0DQo+IHN0YXJ0IGl0ZXJhdGlv
bnMuDQoNCkNhbiB5b3UgY2xhcmlmeSB0aGlzIGEgYml0IGZ1cnRoZXI/IEV2ZW4gdGhvdWdoIHRo
ZSBjb250cm9sbGVyIGlzDQpoYWx0ZWQsIHlvdSBzdGlsbCBvYnNlcnZlZCBhY3Rpdml0eT8NCg0K
PiANCj4gZHdjM19nYWRnZXRfZXBfZGlzYWJsZSAgIG5hbWU9ZXA4aW4gZmxhZ3M9MHgzMDA5ICBk
aXJlY3Rpb249MQ0KPiBkd2MzX2dhZGdldF9lcF9kaXNhYmxlICAgbmFtZT1lcDRpbiBmbGFncz0x
ICBkaXJlY3Rpb249MQ0KPiBkd2MzX2dhZGdldF9lcF9kaXNhYmxlICAgbmFtZT1lcDNvdXQgZmxh
Z3M9MSAgZGlyZWN0aW9uPTANCj4gdXNiX2dhZGdldF9kaXNjb25uZWN0ICAgZGVhY3RpdmF0ZWQ9
MCAgY29ubmVjdGVkPTAgIHJldD0wDQo+IA0KPiBUaGUgc2VxdWVuY2Ugc2hvd3MgdGhhdCB0aGUg
VVNCIGdhZGdldCBkaXNjb25uZWN0IChkd2MzX2dhZGdldF9wdWxsdXAoMCkpDQo+IHJvdXRpbmUg
Y29tcGxldGVkIHN1Y2Nlc3NmdWxseSwgYWxsb3dpbmcgZm9yIHRoZSBVU0IgZ2FkZ2V0IHRvIHBy
b2NlZWQgd2l0aA0KPiBhIFVTQiBnYWRnZXQgY29ubmVjdC4gIEhvd2V2ZXIsIGlmIHRoaXMgb2Nj
dXJzIHRoZSBzeXN0ZW0gcnVucyBpbnRvIGFuDQo+IGlzc3VlIHdoZXJlOg0KPiANCj4gQlVHOiBz
cGlubG9jayBhbHJlYWR5IHVubG9ja2VkIG9uIENQVQ0KPiAgc3Bpbl9idWcrMHgwDQo+ICBkd2Mz
X3JlbW92ZV9yZXF1ZXN0cysweDI3OA0KPiAgZHdjM19lcDBfb3V0X3N0YXJ0KzB4YjANCj4gIF9f
ZHdjM19nYWRnZXRfc3RhcnQrMHgyNWMNCj4gDQo+IFRoaXMgaXMgZHVlIHRvIHRoZSBwZW5kaW5n
IGVuZHhmZXJzLCBsZWFkaW5nIHRvIGdhZGdldCBzdGFydCAody9vIGxvY2sNCj4gaGVsZCkgdG8g
ZXhlY3V0ZSB0aGUgcmVtb3ZlIHJlcXVlc3RzLCB3aGljaCB3aWxsIHVubG9jayB0aGUgZHdjMyBz
cGlubG9jaw0KPiBhcyBwYXJ0IG9mIGdpdmViYWNrLg0KPiANCj4gVG8gbWl0aWdhdGUgdGhpcywg
cmVzb2x2ZSB0aGUgcGVuZGluZyBlbmR4ZmVycyBvbiB0aGUgcHVsbHVwIGRpc2FibGUgcGF0aA0K
PiBieToNCj4gIDEuIFJlLWxvY2F0aW5nIHRoZSBTRVRVUCBwaGFzZSBjaGVjayBhZnRlciBzdG9w
IGFjdGl2ZSB0cmFuc2ZlcnMsIHNpbmNlDQo+ICB0aGF0IGlzIHdoZXJlIHRoZSBEV0MzX0VQX0RF
TEFZX1NUT1AgaXMgcG90ZW50aWFsbHkgc2V0LiAgVGhpcyBhbHNvIGFsbG93cw0KPiAgZm9yIGhh
bmRsaW5nIG9mIGEgaG9zdCB0aGF0IG1heSBiZSB1bnJlc3BvbnNpdmUgYnkgdXNpbmcgdGhlIGNv
bXBsZXRpb24NCj4gIHRpbWVvdXQgdG8gdHJpZ2dlciB0aGUgc3RhbGwgYW5kIHJlc3RhcnQgZm9y
IEVQMC4NCj4gDQo+ICAyLiBEbyBub3QgY2FsbCBnYWRnZXQgc3RvcCB1bnRpbCB0aGUgcG9sbCBm
b3IgY29udHJvbGxlciBoYWx0IGlzDQo+ICBjb21wbGV0ZWQuICBERVZURU4gaXMgY2xlYXJlZCBh
cyBwYXJ0IG9mIGdhZGdldCBzdG9wLCBzbyB0aGUgaW50ZW50aW9uIHRvDQo+ICBhbGxvdyBlcDAg
ZXZlbnRzIHRvIGNvbnRpbnVlIHdoaWxlIHdhaXRpbmcgZm9yIGNvbnRyb2xsZXIgaGFsdCBpcyBu
b3QNCj4gIGhhcHBlbmluZy4NCj4gDQo+IEZpeGVzOiBjOTY2ODM3OThlMjcgKCJ1c2I6IGR3YzM6
IGVwMDogRG9uJ3QgcHJlcGFyZSBiZXlvbmQgU2V0dXAgc3RhZ2UiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAxMDEgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCAzYzYzZmE5N2E2ODAuLjk3MTVkZThlOTli
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xMzksNiArMTM5LDI0IEBAIGludCBkd2MzX2dh
ZGdldF9zZXRfbGlua19zdGF0ZShzdHJ1Y3QgZHdjMyAqZHdjLCBlbnVtIGR3YzNfbGlua19zdGF0
ZSBzdGF0ZSkNCj4gIAlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZv
aWQgZHdjM19lcDBfcmVzZXRfc3RhdGUoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sNCj4gKwl1bnNp
Z25lZCBpbnQJZGlyOw0KPiArDQo+ICsJaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BI
QVNFKSB7DQo+ICsJCWRpciA9ICEhZHdjLT5lcDBfZXhwZWN0X2luOw0KPiArCQlpZiAoZHdjLT5l
cDBzdGF0ZSA9PSBFUDBfREFUQV9QSEFTRSkNCj4gKwkJCWR3YzNfZXAwX2VuZF9jb250cm9sX2Rh
dGEoZHdjLCBkd2MtPmVwc1tkaXJdKTsNCj4gKwkJZWxzZQ0KPiArCQkJZHdjM19lcDBfZW5kX2Nv
bnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzWyFkaXJdKTsNCj4gKw0KPiArCQlkd2MtPmVwc1swXS0+
dHJiX2VucXVldWUgPSAwOw0KPiArCQlkd2MtPmVwc1sxXS0+dHJiX2VucXVldWUgPSAwOw0KPiAr
DQo+ICsJCWR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KGR3Yyk7DQo+ICsJfQ0KPiArfQ0KPiAr
DQoNCkNhbiB3ZSBzZXBhcmF0ZSByZWZhY3RvcmluZyBjaGFuZ2VzIG90aGVyIGZ1bmN0aW9uYWwg
Y2hhbmdlcz8gSXQncw0KZGlmZmljdWx0IHRvIHJldmlldyB3aXRoIHRvbyBtYW55IHRoaW5ncyB0
byBrZWVwIHRyYWNrIG9mLg0KDQpUaGFua3MsDQpUaGluaA==
