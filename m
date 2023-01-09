Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E066333C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbjAIVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbjAIVjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:39:11 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0D19288;
        Mon,  9 Jan 2023 13:37:27 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309L1lu6001627;
        Mon, 9 Jan 2023 13:37:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=kcgafkdaL3vsQaYY9tYfwb5PIZOuTbtfND9A6zZffHY=;
 b=YDLt2OFKU9v/n3JcUasVxQb7JyDXAYb1R6ZYPjR8UhojPXtaNJ/nKKtV20L+pEWgKMQ1
 V57TbGXeNrskQRUML6eIdvOicqmDyhLCSV3jkYmNXtRj31f4l9TlbrKtOu7DvNwSTi5E
 4ziSQAG6T1EHKd/pWFOGgiONkdJ18UqeQmadC8XfGos+i/pyXBPCnXvnMTuagdDKNoO5
 b/ypY7Aa8GlMMOjfQN7FpWN6qvJE2M/3vVq9+h7JO9MLZZuCMxaU2sQWoFMoba8uCW8G
 wg5RMNPx4V1Z6VfMQrUe4WhJGs5QdsGIUAdxF7ssXEixwbAedBMjaeTzBCGpn3TlCyN9 BQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3my8vadxy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 13:37:11 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7107AC00F3;
        Mon,  9 Jan 2023 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673300231; bh=kcgafkdaL3vsQaYY9tYfwb5PIZOuTbtfND9A6zZffHY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J/gOSO082onC3qnz/1QW+U37XHKnfPnjQA7ShUAHXIngb7/oDrAZRO7N3XXG9fSQC
         6GPTO0rbhiJwGUgzwZkuEPCjrsV7/OVhttsk2/ivSrwLukIAAsGPC2tWF9shbavh71
         49HvGS2O+DwrYEC8d+6iSlKNUiyLis2gvA5BeWKLq39KIyei6GglEEOOLcef1fOAHx
         axhSc68jVHxh6Dw5PQ9asOORE+dj09HNefhbgu0zwdpYpcyIPkuN/v1pe9qgAzWmql
         7buMCIP7RosQ40rMxJBJ3Qk5FfpDeoYwbe/HdOH34jsK55Rylkm4QPB2SGi9pcvDrs
         nIJjNjABdt91A==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C0849A0060;
        Mon,  9 Jan 2023 21:37:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CB0E80169;
        Mon,  9 Jan 2023 21:37:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Zznn35vr";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM8p9C9OaprerO1Mguhy+4CrEa8RbIMoFKTzalLde3+0L8Hf8pMsvEaJbwniXdSpDrK4xQ5i/VW26i1RlQ/5GBM71wsMtFyvhuCWPPO7SJunaAJjjgVUqmBp8ERee5F2WONRTCJZlIBJAJTp8X5fWihiBEgLxqXhfzzfTHm2bfpQuVt/10r0NL73eGddlC08FFqR5Xtz9aKkoG6HOO4jQSfrXW8K7cC6RpmJ1GtJwBL4F0PVJPPzOpX4P3ShVjeW+6W7gfzSwvaZkuuxG+/zCkfjQJaF2YgstNXjtWTIgrj2LFA12zr6UtI7oEO8oXrmKN4TFd2wLcTEc5kErc4OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcgafkdaL3vsQaYY9tYfwb5PIZOuTbtfND9A6zZffHY=;
 b=DaOIxgbtA9SnqNT2g9ZgnWC+zk7KpQowQbEVpcrb7/Tiuckq7kJU71xHG1UhgZ7HmGTMypz276FkB8ELb9HCzIsRLQAoQOjw+GhJpK3GYKT88UqnZOLTDPe8JaIxMWXH3caDl1+uomWYFrUSwdoG4VIJaczp/r+dEOg0iTD6sdw3J0Z4dQrAPqKj5WrEy/ef0lf6qU6foYUhgQpKl9JAaU8S8USyjjoQg0ultsYKlWl5Br3pWAzcAl3Zmtx600JnZCWPqSxtjIZyjyrrPSyn1GMrNbhTU4rtK3BRhNQyxIDlv987EsXQpvHO33AhfVwaQt4zLy+907F+dMmdyZy53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcgafkdaL3vsQaYY9tYfwb5PIZOuTbtfND9A6zZffHY=;
 b=Zznn35vrPxevPOJzuqjzIjGk2Qv++9O1zZK//8N1K2DIkZwYh1BqS+ZAYbnM27C054zTWtls3Hivp0B2sNZu4BdHOkwPD6tkzjo0nEOziL3DfzgP0WsUmkh+2l+8/Q8IxXqW49XHoFH0AWGBcBoXAvYj7DChaG1A31qRNlFsiEo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 21:37:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 21:37:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
Thread-Topic: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
Thread-Index: AQHZE93Ovub27gHGRUWi+BBXvB4w9652Yz6AgABs/oCABHtWgIAA4T8AgAEoRICACNjVAIAAiSoAgAAD/wCABmgOgIAJeXoAgAARkoCAAA8RgA==
Date:   Mon, 9 Jan 2023 21:37:02 +0000
Message-ID: <20230109213653.ubft6jfc472ey5cf@synopsys.com>
References: <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh> <20221223235712.h54lggnjjuu3weol@synopsys.com>
 <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
 <87o7rlffi7.fsf@balbi.sh>
 <CAL_Jsq+viP_aY3n378WC7WpxZFnsTc-vKjW9Ojvcy0Ef-z09Ng@mail.gmail.com>
 <87k028g6ol.fsf@balbi.sh>
 <CAL_JsqKjrXsz6hak2rG3GMKaOot4azDWpYCOsQmdVtmszN1WQw@mail.gmail.com>
 <20230109194004.yqaqslcwnqqywkr3@synopsys.com>
 <CAL_JsqLE+v7LkDk_TG_=aT3mUeGb8eVnJmeKLz5w1XmfVPkHeQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLE+v7LkDk_TG_=aT3mUeGb8eVnJmeKLz5w1XmfVPkHeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4370:EE_
x-ms-office365-filtering-correlation-id: afef2cbf-ef86-443b-1380-08daf289a559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6zB3ZVTqc0zJ9YtuftNFdUKCCurts3eMsRqyQfPuAtBZjUschsAPEtu/QmhtxaSy74UXkIi0fTziEjC9oV+NSnrM+3cjvaKTTP+J0/je2ZkyzZifG9DKi30KbSd5h7sGg/vbqhGn5NA58EgdM3hUBGRH46PI1HDcuwmhx1lfFMUAVPUyywVEbRnyQMfesnOOt5U5D39efM7/t2C5JxglYGfrerOqPgrH2JO/JoFgssyUwIAPhsPpuayBQTshzmBCaHyczGQAuYcL06bo6t9jrkHj33YdboEgI0j3DBQ1MHLafLeXEQw9UBsca/0D9CK8RL4MvqaZn64GUHquO4+nRPwQ8/BIiRCyVprkc8m+aFxr6rspLuV8wfhmFA6A0/mYCr4k2HrCX5Wkocm2YDlKgecCvl+dTIAijIUNIb/ljeNACBezAOkm0tAQTxSMD6NOAHTiyyfkTr6KV1ihl7U3jDc/Bjyc2dmVo46tkaXE9rPvfDkl7si0lACSthR45ZfnI1EN4YYYHuGS2Kstq6Tg/+siAOdtHN2qwvJnY1eRTD5rhR/uOyiQIeerhL2tMe+qVAj1DKaOeX/L09tee6z1eUpab1gyJq8DKhleb3yugSbU+DbY3uT97LhXm/sbFWb5Z5iLZWMnuaFKQsHDfBDurat8b6E3q44NkNoO9qWU490jcDoERydyq8fW/5uxeDTVoJWmH6fzwEvIQ7f/PNfa1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(36756003)(38070700005)(86362001)(316002)(54906003)(478600001)(6486002)(186003)(71200400001)(2906002)(7416002)(5660300002)(66446008)(64756008)(76116006)(4326008)(6916009)(66556008)(8936002)(66946007)(8676002)(41300700001)(66476007)(38100700002)(122000001)(6512007)(6506007)(26005)(2616005)(83380400001)(1076003)(53546011)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzhKUFg4T1FRTWFMN3ZRbVNYemVFa3dLc3FXVkdZcnFDQUFPMXRpOUlETDhG?=
 =?utf-8?B?aXdoaEhIWEtIdGJMaFNyaktGV2hjc1hubGE1R3U2dWx2NFNoMWtKR3ZqSk9T?=
 =?utf-8?B?aXVHMkljamVQUGJVd1RQQ2pHRFlTbFpHRk1oOTM3UUxxT2wzQ0F0VFNSTnZh?=
 =?utf-8?B?U2VWWTZrUWZlV1VEMmVnSEVCMVV0aDNFOWUva2xHL3JqQU43QklTWGhFY21Z?=
 =?utf-8?B?UEdVUlpLWHJSRE43d1V4NXRpZUJwS01EM251U1hhTVhrcU9GR1ZKSDE1Qkx0?=
 =?utf-8?B?c0lYdE9ZRUxuaU45SHd4Y2ZKb1JpM1R6WmNqTTNSTDdXM2tVUGFHeXdMMnlF?=
 =?utf-8?B?NVBwUGZKemx0d3o2NHNwM2JKZWdLb1ZsU09adGp1aFVwOUdWd2ZSbHE2bHor?=
 =?utf-8?B?SHpMRmVhZUZvZWYyaXQ1ckdVRDlydnhMZkp0Zit2enhNa09QcTh3QVFOKy9R?=
 =?utf-8?B?dHQyaGVkRWdhcmFuREJhaUJPL2xtY2gzNUF4cWt3elpHZGkrdmh4L3ZoTllr?=
 =?utf-8?B?TEFFNG05cXlMSTZpcUNsakVPa09HZjRGU2FOelBUSUZWTmZURVNnamNvWk5s?=
 =?utf-8?B?RmF3WmNPRHpwYVY4c3k2UFZzY09pRW1wTG1QelA1QS9uZjZlcGVpemtCYnE1?=
 =?utf-8?B?ZWlJREl3Z0VGUzZOcFR0NEVWZnNqSDhwdXM0WUJGM1MrUjVmeU9qQTVOYlFr?=
 =?utf-8?B?cE1WNFdNZjQ1emJqMTIvTThkemVhZnQwWm9HZGVnL09icXZDVmFLOXNrZ0R0?=
 =?utf-8?B?MUJBekdvcFVLNVcxRktwU0lHaE1wR3BmQkpiMkpuVVhiVzRHNzJSZ2o3V0E0?=
 =?utf-8?B?TWY2T1I1SlY0N1dLVHc3bTVPd2pDK0J6NDlGaERVZXhpV0lmaWE2UDdOcy8v?=
 =?utf-8?B?ZVlmRTZQK3dDbGdGSUlFUTNNRmwrYlNPdWN2NnRsSE9CUzAydHBtNFJPMnk0?=
 =?utf-8?B?ZHg1ZVJ4UTNCTDZwczNvbXp1VXllRjRIR2dSM0p6QlpMVW9JMFBpK1lZQXRv?=
 =?utf-8?B?OGtSbGh6THBiR25VL2ZGQ1prUmV5TFhUaWFqcFp4SnN0MFNoV1ZNaGozb09l?=
 =?utf-8?B?TlJQQUJYNVQyb3ZWOTRXR0l0aktqL3FyTlhCdzR6c1JuUFVITXBmNHdMak0z?=
 =?utf-8?B?andGUlNLNVhYQWlLTVc2NDIzOHVNNXFLRHB3Y0hyYlZGcUwrWHcxK2Z0eUQ2?=
 =?utf-8?B?RXlxVllvdWs4dGlyeFNPV3dVcUtVc1habFVmMDNMRlpPS3Y2VHU3WFNycWRJ?=
 =?utf-8?B?RysxMU1HTC9La3ErL05RbHo1NENOclV3Z2ZoTjVpSkwxUXpIOGRDclhoYmtx?=
 =?utf-8?B?SktYUTdzRWtURHB0VUJraThsa0Fwazdpc3NxYldTNzdITWs2RDBORldoVWZ6?=
 =?utf-8?B?ZXkrTi9nL2p2NEp6MzFocVlsbGRrK3RhTWVQekdvYVVncDNxOFU2Rm8yQ0sw?=
 =?utf-8?B?cUR0OXRTUmRvazIyNWFlTnpzZHZNaVBmYlBNcTkvMXRUaHFBQ3dpTHJReUlO?=
 =?utf-8?B?MHVvc2Z1dEVlUXlTR2EwU0JJdUNCWGNZRkZLZ1M3M3d1RGRRRk1XUDhScVpk?=
 =?utf-8?B?NWs4RnhoQ05KQ2tiamNQQUd2dU8wNStIcWZ5bkNIVDFjZUpvbU1tM2dXRGRQ?=
 =?utf-8?B?dUhieVNJbEZLY2V3UDJoUFVlK05nNkFsTEx1dURVSkhnd0RCbHlVWWJhOHhs?=
 =?utf-8?B?dncxemg1aW00WW4rR2puY2J6a0ptZDJuR0tYdk9CQ3FMU3lGSEExaDh4MG8y?=
 =?utf-8?B?QjE0UHF5QlRHT2ZqUm9EcmFzWGoyV3hsejFTQitBbmVERnVMTzh2aWt4TzRI?=
 =?utf-8?B?ckhUS2xvNFRld1FpYmZTK0xsTkVjazVwMEhEbUlUNlhBSTRDOHp2SldWV3hp?=
 =?utf-8?B?cU9xbWhnU1MxM0MyMW1DTlNMY2RkbTJsdXhwUjliVUhzZGpNU1MyR1JjM0ZE?=
 =?utf-8?B?S1hDd2RuemZ2UERUYlI5Z0IvY3doR2RKcnBlT2R2aFVBaXozSWR5OFVOVUlE?=
 =?utf-8?B?NDR0YXVkT3I4WEorK2dGaENSak0vcDQyMEgyOURYL1dySjFRN29keVJJR0lT?=
 =?utf-8?B?TGs0RUQyOW01RlA1SWNhelJUSmlVRUxVaStzYzAxRVZqbTV3YW9JWkJDQU95?=
 =?utf-8?B?cU81WHoxL0VEL0liZDZHVDZnY2pGSEpucHJOckhxSUVUZGlDQXZWZ0U0bERy?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930D7B039A347D4382F8A72ED1F60D18@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d0N3emNWTDduMVpkRU1Tdm4rcmIvdVo0U0R0ZDJmRi83ME9EWTRzQkgwaU5v?=
 =?utf-8?B?azBaWFl0WklvTHA1NTFXR2dnVFd3bTFjNzZ5bEpnS1llVnNWbHQ4aW90OUVK?=
 =?utf-8?B?cTZjNW5ITkFXWkhJTEZlTnlvb041UHNsNTJxVWdBRE9sYUFEUDhLSXUzZ1ZJ?=
 =?utf-8?B?WWswMXM1dGhEamwrWm5SMVpsZWhNVjkwWFE4ZC9uK21QK2lUUkRZVk11SEsz?=
 =?utf-8?B?NG5sS2dqNlplSS83VHF5TEx2WUNGeTdmdFJKREJQSWJSWFVCVmpETlBMei9G?=
 =?utf-8?B?cHVablg2amMvNExQdlY2c2pyVzFYNjhUOSsxRllteWZiSTNEWC9hSHBJaW9T?=
 =?utf-8?B?OUJiL0NibCsxOXJTRXdJb21YSWVLeHluN1NSMUFNd0Uraml3ZG5wejBaamVx?=
 =?utf-8?B?ZDhMK3RvWGpCcVZWMXJzMjI5enk2N0Z5aUo4TzRVWGFpa0w4cnFBQ2R5NllX?=
 =?utf-8?B?LzRsdi9NeEY1cG9XTzNmVkxRZHNSZEEvK0p2K01OU3ZrWlZpNkJSYkxIYkFi?=
 =?utf-8?B?ZlhvL1VFNi9kcVJhazNMUE81MzdUbEpSckdQYlhyR05lczl0RzJ6Y0s3Si9B?=
 =?utf-8?B?aFJrTVI4eFBCK3ZPN2lvL3hEQ3I0OGl6L1Y3dXh0RlNQdG1RVWhRaE4vbnhw?=
 =?utf-8?B?MTBUQk1vRmloa0s5VVh2V1c2WFVMNGxJVGg1ZTJwOUlIeGdrUEZEVHJYaFVz?=
 =?utf-8?B?RTZrdklxeW9QU1A2dlgrUkZrZVJVc1VDY3E2aGc4ekcyaHVBUUxXVlpDc0Vj?=
 =?utf-8?B?K2JtNzI1Q2FrazBTcURLLzgrODlNN2VocjI3QmZlOUZiZXlnemFPOGMzWVJN?=
 =?utf-8?B?L2VnbEhDcjVCM2s4K0tBa3VDeDVLQkgwTTJUTEp5YXdkTm0vT3dtSEU5dlNV?=
 =?utf-8?B?UDQvNDFxODFHSVhhOFg2ZmxOTVBiS0JIcTkxSjdTUmZIa0xkWlhOWkxZM1ox?=
 =?utf-8?B?M2FRdVNuMHlYa1NmblZrdXZxUzJGTVFCbU5iMXRoTXNMK3ZOM1V3aFJNS29w?=
 =?utf-8?B?Mzl2dHVrY2hIYWd3SkNpcWY4WGZFRUtYUXZ5ZTVUVjQ3eXQ5WnJRNWgvNElP?=
 =?utf-8?B?Z0R2ZlZTTUF3S2d1cDgxbUpLdVc0dGJYR3QzSWk0dHZ0ZHpSZThCZVlhTGFV?=
 =?utf-8?B?cDlteXVJT0ozVWZLN2RoaUhsTkxXV1Jab0pMZ0hlOGgzTEcvbnBpcE5PbkdN?=
 =?utf-8?B?WVYvVjdGZ0lQakVFekdqdEl2Lzk0OWdXMmhoa2FsVkY3MHVxQ3pCaVhwV0lX?=
 =?utf-8?B?b2pzcTgwY001Q1BPcVlQN1NLNTZ4OU5MUnJvam5SRGhFWG8xeHZoQzNXRFVq?=
 =?utf-8?B?V2l3cVZOVWcxRFFaalBvNmtXbmRwZDdJcE5kZmFOTXQ5S3JFSVlSZDlMM3NS?=
 =?utf-8?B?WW5iNDI2dVFJUGc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afef2cbf-ef86-443b-1380-08daf289a559
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 21:37:02.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4Rn7oHb6QCnB4oUbuK+fC5nt636KUmQ/ULL3NAbU7+Iq5xMjtCtxThTAoXZRlM+fCtAIUqAkS5Ua/jj8E0m8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Proofpoint-ORIG-GUID: Ryw9Tv4fLHPJ7GUkHeQO_i1kttvO4s4V
X-Proofpoint-GUID: Ryw9Tv4fLHPJ7GUkHeQO_i1kttvO4s4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301090150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMDksIDIwMjMsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBNb24sIEphbiA5
LCAyMDIzIGF0IDE6NDAgUE0gVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29t
PiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgSmFuIDAzLCAyMDIzLCBSb2IgSGVycmluZyB3cm90
ZToNCj4gPiA+IE9uIEZyaSwgRGVjIDMwLCAyMDIyIGF0IDExOjA5IEFNIEZlbGlwZSBCYWxiaSA8
YmFsYmlAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhpLA0K
PiA+ID4gPg0KPiA+ID4gPiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cml0ZXM6DQo+
ID4gPiA+ID4+ID4+ID4gPj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi9zbnBzLGR3YzMueWFtbCB8IDMgKysrDQo+ID4gPiA+ID4+ID4+ID4gPj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+PiA+PiA+ID4+ID4NCj4gPiA+ID4gPj4g
Pj4gPiA+PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3NucHMsZHdjMy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi9zbnBzLGR3YzMueWFtbA0KPiA+ID4gPiA+PiA+PiA+ID4+ID4gaW5kZXggNmQ3ODA0OGM0NjEz
Li5iY2VmZDFjMjQxMGEgMTAwNjQ0DQo+ID4gPiA+ID4+ID4+ID4gPj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sDQo+ID4gPiA+ID4+
ID4+ID4gPj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3Nu
cHMsZHdjMy55YW1sDQo+ID4gPiA+ID4+ID4+ID4gPj4gPiBAQCAtOTEsNiArOTEsOSBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ID4gPiA+PiA+PiA+ID4+ID4gICAgICAgICAgLSB1c2IyLXBoeQ0KPiA+ID4g
PiA+PiA+PiA+ID4+ID4gICAgICAgICAgLSB1c2IzLXBoeQ0KPiA+ID4gPiA+PiA+PiA+ID4+ID4N
Cj4gPiA+ID4gPj4gPj4gPiA+PiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gPiA+ID4+ID4+ID4g
Pj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4+ID4+ID4gPj4NCj4gPiA+ID4gPj4gPj4g
PiA+PiBBRkFJQ1QgdGhpcyBjYW4gYmUgaW5jb3JyZWN0LiBBbHNvLCB5b3UgY291bGQgaGF2ZSBD
YyB0aGUgZHdjMw0KPiA+ID4gPiA+PiA+PiA+ID4+IG1haW50YWluZXIgdG8gZ2V0IGNvbW1lbnRz
Lg0KPiA+ID4gPiA+PiA+Pg0KPiA+ID4gPiA+PiA+PiBGZWxpcGUgaXMgY29ycmVjdC4gV2UgaGF2
ZSAyIHBvd2VyLWRvbWFpbnM6IENvcmUgZG9tYWluIGFuZCBQTVUuDQo+ID4gPiA+ID4+ID4NCj4g
PiA+ID4gPj4gPiBQb3dlciBtYW5hZ2VtZW50IHVuaXQ/IFBlcmZvcm1hbmNlIG1hbmFnZW1lbnQg
dW5pdD8NCj4gPiA+ID4gPj4gPg0KPiA+ID4gPiA+PiA+IFRoYXQgZG9lc24ndCBjaGFuZ2UgdGhh
dCB0aGUgcmszMzk5IGlzIDEgYW5kIHdlJ3JlIHN0dWNrIHdpdGggaXQuIFNvIEkNCj4gPiA+ID4g
Pj4gPiBjYW4gc2F5IDEgb3IgMiBkb21haW5zLCBvciB3ZSBhZGQgdGhlIDJuZCBkb21haW4gd2hl
biBzb21lb25lIG5lZWRzDQo+ID4gPiA+ID4+ID4gaXQuDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+
IElzbid0IHRoZSBzbnBzLGR3YzMueWFtbCBkb2N1bWVudCBzdXBwb3NlZCB0byBkb2N1bWVudCBk
d2MzJ3MgdmlldyBvZg0KPiA+ID4gPiA+PiB0aGUgd29ybGQ/IEluIHRoYXQgY2FzZSwgZHdjMyBl
eHBlY3RzIDIgcG93ZXIgZG9tYWlucy4gSXQganVzdCBzbw0KPiA+ID4gPiA+PiBoYXBwZW5zIHRo
YXQgaW4gcmszMzk5IHRoZXkgYXJlIGZlZCBmcm9tIHRoZSBzYW1lIHBvd2VyIHN1cHBseSwgYnV0
DQo+ID4gPiA+ID4+IGR3YzMnIHN0aWxsIHRoaW5rcyB0aGVyZSBhcmUgdHdvIG9mIHRoZW0uIE5v
Pw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWWVzLiBUaGF0IGlzIGhvdyBiaW5kaW5ncyAqc2hvdWxk
KiBiZS4gSG93ZXZlciwgUkszMzk5IGRlZmluZWQgb25lIFBEDQo+ID4gPiA+ID4gbG9uZyBhZ28g
YW5kIGl0J3MgYW4gQUJJLiBTbyB3ZSBhcmUgc3R1Y2sgd2l0aCBpdC4gRXZlcnlvbmUgZWxzZSBw
dXQNCj4gPiA+ID4NCj4gPiA+ID4gQXJlIHlvdSBjb25mdXNpbmcgdGhpbmdzLCBwZXJoYXBzPyBE
V0MzLCB0aGUgYmxvY2sgU3lub3BzeXMgbGljZW5zZXMsDQo+ID4gPiA+IGhhcywgYXMgVGhpbmgg
Y29uZmlybWVkLCAyIGludGVybmFsIHBvd2VyIGRvbWFpbnMuIEhvdyBPRU1zIChUSSwgSW50ZWws
DQo+ID4gPiA+IFJvY2tjaGlwLCBBbGx3aW5uZXIsIGV0YykgZGVjaWRlIHRvIGludGVncmF0ZSB0
aGUgSVAgaW50byB0aGVpciBzeXN0ZW1zDQo+ID4gPiA+IGlzIHNvbWV0aGluZyBkaWZmZXJlbnQu
IFRoYXQgaXMgcGFydCBvZiB0aGUgKHNvLWNhbGxlZCkNCj4gPiA+ID4gd3JhcHBlci4gRGlmZmVy
ZW50IGludGVncmF0b3JzIHdpbGwgd3JhcCBTeW5vcHN5cyBJUCBob3dldmVyIHRoZXkgc2VlDQo+
ID4gPiA+IGZpdCwgYXMgbG9uZyBhcyB0aGV5IGNhbiBwcm92aWRlIGEgc3VpdGFibGUgdHJhbnNs
YXRpb24gbGF5ZXIgYmV0d2Vlbg0KPiA+ID4gPiBTeW5vcHN5cyBvd24gdmlldyBvZiB0aGUgd29y
bGQgKGl0cyBvd24gaW50ZXJjb25uZWN0IGltcGxlbWVudGF0aW9uLCBvZg0KPiA+ID4gPiB3aGlj
aCB0aGVyZSBhcmUgMyB0byBjaG9vc2UgZnJvbSwgSUlSQykgYW5kIHRoZSByZXN0IG9mIHRoZSBT
b0MuDQo+ID4gPiA+DQo+ID4gPiA+IFBlcmhhcHMgd2hhdCBSSzMzOTkgZGlkIHdhcyBwcm92aWRl
IGEgc2luZ2xlIHBvd2VyIGRvbWFpbiBhdCB0aGUgd3JhcHBlcg0KPiA+ID4gPiBsZXZlbCB0aGF0
IGZlZWRzIGJvdGggb2YgRFdDMydzIG93biBwb3dlciBkb21haW5zLCBidXQgRFdDMyBpdHNlbGYg
c3RpbGwNCj4gPg0KPiA+IEp1c3QgZm9yIHNvbWUgYWRkaXRpb25hbCBjb250ZXh0L3VzZSBjYXNl
LCB0aGUgcG93ZXIgdG8gdGhlIFBNVSAocG93ZXINCj4gPiBtYW5hZ2VtZW50IHVuaXQpIG11c3Qg
YWx3YXlzIGJlIG9uLiBJZiB0aGUgZGV2aWNlIHN1cHBvcnRzIGhpYmVybmF0aW9uLA0KPiA+IGlu
IGhpYmVybmF0aW9uLCB0aGUgcG93ZXIgc3VwcGx5IHRvIHRoZSBjb3JlIGNhbiBiZSB0dXJuZWQg
b2ZmLg0KPiANCj4gVGhpbmdzIGluIGFuIGFsd2F5cy1vbiBQRCBtYXkgb3IgbWF5IG5vdCBiZSBk
ZXNjcmliZWQgaW4NCg0KSSdtIGp1c3QgcHJvdmlkaW5nIGFkZGl0aW9uYWwgaW5mbywgYW5kIG5v
dCBldmVyeXRoaW5nIGlzIG5lY2Vzc2FyaWx5DQpuZWVkZWQgZm9yIHRoZSBEVCBkZXNjcmlwdGlv
bi4NCg0KPiAncG93ZXItZG9tYWlucycsIHNvIGZyb20gYSBEVCBwZXJzcGVjdGl2ZSBJIHdvdWxk
IHNheSAxIGRvbWFpbiBpcw0KPiBwZXJmZWN0bHkgdmFsaWQgaGVyZS4NCj4gDQo+IEkgc3VwcG9z
ZSB0aGUgUE1VIGNvdWxkIGJlIGluIGEgUEQgd2hpY2ggY2FuIGJlIGdhdGVkIG9mZiwgYnV0IGFu
eQ0KPiBoaWJlcm5hdGlvbiBmZWF0dXJlcyB3b3VsZCBiZSBsb3N0Lg0KPiANCg0KU29tZSBkZXZp
Y2VzIGhhdmUgYm90aCB0aGUgY29yZSBhbmQgdGhlIFBNVSBpbiB0aGUgc2FtZSBwb3dlciBkb21h
aW4sDQp3aGljaCBtYXkgYmUgdGhlIGNhc2UgZm9yIFJLMzM5OS4gSG93ZXZlciwgdGhlIFBNVXMg
bWF5IGJlIGltcGxlbWVudGVkDQppbiBhIHNlcGFyYXRlIHBvd2VyIHJhaWwgdGhhbiB0aGUgY29y
ZS4NCg0KPiA+ID4gPiBoYXMgMiBwb3dlciBkb21haW5zLCB0aGF0J3Mgbm90IHNvbWV0aGluZyBy
b2NrY2hpcCBjYW4gY2hhbmdlIHdpdGhvdXQNCj4gPiA+ID4gcmlza2luZyB0aGUgbG9zcyBvZiBz
dXBwb3J0IGZyb20gU3lub3BzeXMsIGFzIGl0IHdvdWxkIG5vdCBiZSBTeW5vcHN5cw0KPiA+ID4g
PiBJUCBhbnltb3JlLg0KPiA+ID4NCj4gPiA+IEFnYWluLCBub25lIG9mIHRoaXMgbWF0dGVycy4g
SSdtIGRvY3VtZW50aW5nIHdoYXQgaXMgYWxyZWFkeSBpbiB1c2UNCj4gPiA+IGFuZCBhbiBBQkks
IG5vdCB3aGF0IGlzIGNvcnJlY3QuIFRoZSB0aW1lIGZvciBjb3JyZWN0bmVzcyB3YXMgd2hlbg0K
PiA+ID4gdGhpcyBiaW5kaW5nIHdhcyBhZGRlZC4NCj4gPg0KPiA+IFRoYXQncyB1bmZvcnR1bmF0
ZS4gVGhhdCBtYWtlcyB0aGlzIHZlcnkgZGlmZmljdWx0IHRvIG1haW50YWluIGlmIHdlDQo+ID4g
Y2FuJ3QgcmVjdGlmeSBhIG1pc3Rha2UuDQo+IA0KPiBTaHJ1Zy4gV2hhdCdzIHVuZm9ydHVuYXRl
IGlzIG9ubHkgYSBsaW1pdGVkIG51bWJlciBvZiBwZW9wbGUgY2FuDQo+IHJldmlldyBiaW5kaW5n
cyB0byBiZSBjb3JyZWN0IGluIHRoaXMgYXNwZWN0LiBBbmQgSSdtIG5vdCBvbmUgb2YgdGhlbS4N
Cj4gDQo+IFdlIGRlYWwgd2l0aCB0aGlzIGFsbCB0aGUgdGltZSBhbHJlYWR5LiBJdCdzIGp1c3Qg
YW1wbGlmaWVkIHdoZW4gaXQgaXMNCj4gc2hhcmVkIElQLiBXb3VsZCBJIGxpa2UgbGVzcyB2YXJp
YXRpb24/IFllcywgYnV0IGl0J3Mgbm90IGENCj4gc2hvd3N0b3BwZXIuDQo+IA0KPiA+ID4gVG8g
bW92ZSBmb3J3YXJkLCBob3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiA+DQo+ID4g
PiBwb3dlci1kb21haW5zOg0KPiA+ID4gICBkZXNjcmlwdGlvbjogUmVhbGx5IHRoZXJlIGFyZSAy
IFBEcywgYnV0IHNvbWUgaW1wbGVtZW50YXRpb25zDQo+ID4gPiBkZWZpbmVkIGEgc2luZ2xlIFBE
Lg0KPiA+ID4gICBtaW5JdGVtczogMQ0KPiA+ID4gICBpdGVtczoNCj4gPiA+ICAgICAtIGRlc2Ny
aXB0aW9uOiBjb3JlDQo+ID4gPiAgICAgLSBkZXNjcmlwdGlvbjogUE1VDQo+ID4gPg0KPiA+ID4g
V2UgdW5mb3J0dW5hdGVseSBjYW4ndCBjb25zdHJhaW4gdGhpcyB0byBSb2NrY2hpcCBpbiB0aGUg
c2NoZW1hDQo+ID4gPiBiZWNhdXNlIHRoYXQgc3BlY2lmaWMgaW5mb3JtYXRpb24gaXMgaW4gdGhl
IHBhcmVudCBub2RlLg0KPiA+ID4NCj4gPiA+IChraW5kIG9mIGNyYXBweSBkZXNjcmlwdGlvbnMg
dG9vLCBidXQgdGhhdCdzIHRoZSBhbW91bnQgb2YgaW5mb3JtYXRpb24gSSBoYXZlLikNCj4gPg0K
PiA+IENhbiB3ZSBvbWl0IG1lbnRpb25pbmcgbWluIG9yIG1heEl0ZW1zPyBXaGlsZSBpdCBtYXkg
bm90IGJlIGRlc2lyZWQsDQo+ID4gaXQncyBub3QgYSBoYXJkIHJlcXVpcmVtZW50IHJpZ2h0PyBU
aGlzIGNhbiBoZWxwIGF2b2lkIHNvbWUgY29uZnVzaW9uDQo+ID4gd2l0aCBkZXZpY2V0cmVlIGRv
Y3VtZW50YXRpb24gYW5kIGR3YzMgZGF0YWJvb2suDQo+IA0KPiBXaHk/IERvbid0IHlvdSB3YW50
IHRvIGNhdGNoIHNvbWVvbmUgZGVmaW5pbmcgMyBkb21haW5zPw0KPiANCg0KTXkgY29uY2VybiB3
YXMgbW9yZSBhYm91dCAibWF4SXRlbXM6IDEiIG1heSBjYXVzZSBzb21lIGNvbmZ1c2lvbi4gSWYg
d2UNCmNhbid0IHNheSAibWF4SXRlbXM6IDIiLCBvbWl0dGluZyBpdCBvciB1c2luZyAibWluSXRl
bXM6IDEiIHNlZW1zIHRvIGJlDQphIGJldHRlciBvcHRpb24uDQoNCkFzIHlvdSBtZW50aW9uZWQs
IHdlIGNhbid0IGRvIG11Y2ggYWJvdXQgaXQgbm93IHRoYXQgaXQncyBwYXJ0IG9mIHRoZQ0KRFQu
IEkndmUgcHJvdmlkZWQgdGhlIGluZm8geW91IG5lZWQgdG8gbWFrZSB0aGUgYXBwcm9wcmlhdGUg
Y2hhbmdlLg0KTG9va3MgbGlrZSB0aGVyZSdzIG5vIHBlcmZlY3Qgc29sdXRpb24uIFBsZWFzZSBt
YWtlIHRoZSBjaGFuZ2UgeW91IHNlZQ0KYmVzdCBmaXQuDQoNClRoYW5rcywNClRoaW5o
