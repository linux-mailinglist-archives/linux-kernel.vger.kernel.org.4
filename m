Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89873C3DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjFWWPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFWWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:15:20 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026D026B9;
        Fri, 23 Jun 2023 15:15:18 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NLv8aY003040;
        Fri, 23 Jun 2023 15:14:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rDcuPS5H5zYzKvdlu0BM82P3ZFE5+ZpityvE5tVdwQo=;
 b=CRG9BbfTbl5ubSx+/h6WqA0pmoSxTR0LPC/BP1uOhxSaP17xPj9XJKT4HYejaFNLjfbP
 YiHXSVZBs9lNWs28x44A1Ysh1x/RoP+lRPlLVC/dmN0uOE8RrxQqHylADckN5oBG3Qy5
 kZfaAkFHbWJo7PgBxmGuO2rWSVAKMtM9dIHNTk3g17a/ChBhtyeuh4YwDC1nJIIOBgkT
 EQToO0br+XvKmTmde5FtuWwCOuoqglD74V5YyZ7suC2uJz8fJTZP4t7O1u33GTVMStei
 rDd8mkMUYstumf86v2GLmil7xijvePemW9xhJW9upA6rNzSc6kljbPEBnWSCw/Pt1PbS 6w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3r9bferfge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 15:14:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1687558498; bh=rDcuPS5H5zYzKvdlu0BM82P3ZFE5+ZpityvE5tVdwQo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gytTE9kapmtbgYKCK1rLgl6NP2tBEBFuzCE5Y+wjuvijBeS47SQXoNPMHnGjTqj4C
         xfW3F6Rg1U2oOI4l0MatY82mD+HA3p0XC6wQZwupY8xO0eLAGsbQ30VYZl/VdhuVaE
         z0bGU+X77lWjOyrW+SX9X/fdES0ZXKdsaAYuvvyWHLXJozFJPgniQj+prBZRRun24O
         Mwm16myh24Q79sh333QlFnjWJj9yxOwfYPXQTQCtRkvX5WdTMk5QrPvy4nnw+qCBnO
         UFQZVpYOql+0BpavgN7LizSKYMu4vWBCJOOkd/d9nfhPofr00/xPDiRXgk5sodTItt
         eZCzYa6ahiz0Q==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 28CAE40236;
        Fri, 23 Jun 2023 22:14:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0DFFAA0073;
        Fri, 23 Jun 2023 22:14:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lB5GDWqF;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5D1D440121;
        Fri, 23 Jun 2023 22:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIhVcVnu3DZVVBdv6/75XNf5fTGd+mBTdNEJRKI/AHgqO63idh8Ta5RA2HrnhBkpunlcAOIQkZxDQyrBjtgynt/C/GRyp0KTg6vOYd5zg3xB0EJGxE7AW3CIq/FtQ8HkkfiP/yPa8qV001qMN3BjgR3FmHHKaxbW97xqBmyfwOT1BXeaC8OqRUjyNZf8zrs/6des0liAq1yuckyU+LOuHSayqhcZCFZvy7FeUttPf0SKIyWKI2MTKTn+YHsLGSMYtHxK7kxUnL2X8aPTtaP34/TIV4AEZZerUa++pOrNuzou8qi3azbjN4P4rl4cBEco5Ys2vyFKIQyfAuBfdIgr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDcuPS5H5zYzKvdlu0BM82P3ZFE5+ZpityvE5tVdwQo=;
 b=TG9A1XT7pSjmOvVrpuDSTj7ifZmauIIgfGvlJfo53Qd1bu/EihiBs8iNSCVa1jjdNErlqkx6zkUQvmhc+HO1cqafqRO+fscSEkrYvomWB8bDHoNpWKWsrHzX4JXrcgjEbC99UEBhpNNyYb8XzftWgrFdDz0BRHKkz9jpPTeTgK0YD8qCumpHDNzlCr42RxPK/JK3Yyjz4iuiKQySUDdLTe6UsZdy0fj7LVj8a8bolt4lvcE0Tkuog32E0ruNh3TDf7oe3Nv0QcFJ6RxH2/rHOtD5uElrm7ceBbDAgLiuId7bdpt3j4JbYbIfQuZJNSds9OWSbrkAaULui3M5De5Pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDcuPS5H5zYzKvdlu0BM82P3ZFE5+ZpityvE5tVdwQo=;
 b=lB5GDWqF/hbODhiZzjdenMUk/hpaYRJt5wKpHRuGWYmK2QL9dBghCjGxixvtyuME86NsBDS+v86+hH8A7EX16GsFW73HT3VlEW//OD//xQ6O9rcnofvOD16LNu81HfhB/NJHjNMuHUhKy0trkHAJyvVrcd7hocIDkaAlcPUo9Gc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 22:14:49 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:14:49 +0000
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
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZo/oQwKfrvdKqnE6v71hgYZCq86+Y+EgA
Date:   Fri, 23 Jun 2023 22:14:49 +0000
Message-ID: <20230623221446.ia5is2qro4syd7oq@synopsys.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-4-quic_kriskura@quicinc.com>
In-Reply-To: <20230621043628.21485-4-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY5PR12MB6477:EE_
x-ms-office365-filtering-correlation-id: 049cfe8c-d483-494b-c56f-08db74374289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HysL1ktuoT01jyE10ySNkJlM2SjjCLeXHDVUNDq5iDocdKA/5yAFOXBoxM2n+zVOgdwdleDxb4JeOqA2vdjfqTIGm7YekOQ3FTgao4smN4lAmb527oQ9tauIq9N8N076gdyGTQJVFvoarex0McV3aZdHEitkRbHUrqD01VoOQQZrhUtB07DEa7rhs+uCnlqnrPYfKY90Rx765yaDmANETSINtfuWJxQyy9b4Z/itOq6m6HCdxIK5BFwQ0n2qq+ozomA8SlAS1A0IHLPlQb3/eVtEmqQFT6effBdZakRUwqwZg+AzmHU0hskTCz5P3aJAdybf3bIMW5uCOCao2L+OwMjnk5kHcQSH5p1GYoVMUqrtkXTWF8UQACT8r7SZayG1T2t97DgvY+pQJipUxQmTYzztj+YTPHFxGtQJ2qhiEAimie3QQQlQHKizHgpHi3UtOg3YwdgUhvvBiinbrPd8JCF7iYcPpJwzKToIejYWA6/xYlUCeRLhpgaFM9Y+LFbAT7ga287Q5JZgLQ2LGzJU4q4PN1FLJwsmBYD4jPFu8HISaHMHOZm9BWG4voezz/gJHp5nASjpwt78lQjHfeDS+w2tvng2/ImsOvVd+cPBCy7nf74qoe+OOiuh/C90U4jN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(54906003)(86362001)(2616005)(478600001)(71200400001)(6486002)(186003)(41300700001)(4326008)(76116006)(316002)(6916009)(83380400001)(66476007)(6512007)(66556008)(64756008)(26005)(66446008)(1076003)(6506007)(66946007)(8676002)(8936002)(5660300002)(36756003)(7416002)(38100700002)(38070700005)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVlGNjlSalNTZWhjV0JodVI3MU1hUGZyQlNoTEJnaWVpams5bnJxS2o0bDdu?=
 =?utf-8?B?NGhaSEw0Mm5FeFBwMTVnRnVuRytqME04VjljVlBQTFF6a2VqRVI4ZytoZ1ZP?=
 =?utf-8?B?RDdpQ0NGSU1OU2VoK0RiS3IyOEFVb1FFdHRQd0k2V05EOW1BS1lUUzErTHBp?=
 =?utf-8?B?VEVDZEt2ZWZETmkzdGpYWW9lN2R6cmNUd3NndkVyZ2Y2TU5Ra0t2SnhITEpN?=
 =?utf-8?B?ZWZQMHh6bnRSbEFXQ3hORmZsQ2J1MURRMnRmbVdWbmc3Z1VGL0JqdHdYODU0?=
 =?utf-8?B?alY5Y1o2Ujk1ZXlBbVdzT3B0eTdxUCtkeWlOeVlGNnRsTWhieTFYQ0Q1ei84?=
 =?utf-8?B?NkFxZXM2cjFnbFhqSGwzeXdqY0pKYmJ3Q1p6YzRDUGJVdGttQVlmUW52TjFV?=
 =?utf-8?B?SW9NRm5mMmxWK09kN21xaHYyMlpUNjloTm9DWUZRQ0VaNjErd1lvU0FXUWtt?=
 =?utf-8?B?amMrNUpMa0dmTU9uY3kvTGlCYjBBeUVDR3pZVml0ZjhQY083dEd5aUJKU1px?=
 =?utf-8?B?OU4wV3NsdkdaWXVoU3lDUng4MUpCSm9tRjdQenhCcGNtR3Z2Q2xOQjdHSjdX?=
 =?utf-8?B?ckFyL2g4bnhJeEcxeU9QUmRiWS9uc09WWFcwRTArTW16VStjUWRmbDRUTitT?=
 =?utf-8?B?UUZ4MThqYnlpLzJZcmNCQ3BpKzEveHljZzZiQ0UrVHVSSElqV3R6U2owNXVW?=
 =?utf-8?B?MUovaEVRd3Y4cnJjUzk0RGxHQ2xkQmRrYTNudzlSM2t6blA4VWhWcGM4ZjY2?=
 =?utf-8?B?YVRpWU9xOWF5ZkV0cHdEUnc5THZ3K01SQ0NCVElPWHBlVjBtV01mcnpNOGc1?=
 =?utf-8?B?aE1sNEVrb2QrWG1nRDV4UUpzSzAvVW9OcHNyUHk5dUVkbWNxK3RVcktIQXlG?=
 =?utf-8?B?YnI1N1ViN3FRY0JVQWJqQkNMRHpPOEcvOGNJeVJLZGtHS0NCWExOemNUWG02?=
 =?utf-8?B?enI1YXFvVDhVUlBlK1VpSURZbUpHMDNiM3JuK2w1KzNFVzN5ZFF2MkNyeDB4?=
 =?utf-8?B?Q01kRFFKM0RLOG42UlV5VG5rUGVQU0tpTUpSNnlKYys4QU5vc3BOb2grK0Qy?=
 =?utf-8?B?V3grTzE0ZWtkWUozdzZiZkxkbUJ2TGJzSTl3Z0x0U3EvWFhRcU8ybStXSlFo?=
 =?utf-8?B?bldobnJNa0NtTkxhUERwR2ltUTNPUzdINlNhLzFCNmRFWHc5YWh0TERZVmlo?=
 =?utf-8?B?WFluRE9kc1NEeEJnRk9vK01ja05FR3h6OXRHRk9XRThtL05hTXJJaHlBd3Vk?=
 =?utf-8?B?dUErb3JhTzRTN3c2R3VkeFN5Z1ZUUWdaWFhUTmhaU2xLdzh1OE9RaWdWcnRp?=
 =?utf-8?B?bFpKalcxVDAyUHV1SXhRZm1Icm5mNE4vK3dPNlBYUkl2YkpMSE93RkFGSU1N?=
 =?utf-8?B?K0sraUg0clhLMUtlUldzb00wYUE2VzhhMjhFNVhLM3k4WjFwei9EdkJuMzQ5?=
 =?utf-8?B?YlJHUlB4bE5kNWUzallSMXFMU1YxRjh3SERDSlRNT0pZTDlJTFhJOVQzeHpv?=
 =?utf-8?B?ajdob1Jxd0gwdzgwNmRaMmdoRjVXUDR3WVFCSk83aW5LaE94YW5Xck9ockM2?=
 =?utf-8?B?YlBFMzI1NkhYV0JCWWtXVXVCdVJPZHlsaUpsSmw3ck1sc0xsdGtMVy9CT0dl?=
 =?utf-8?B?TldPK3VEdEZQZDJod0tZSDZTeHFDdG5lT3UxeG9pRHB6a0U0TTJBcFlScUJP?=
 =?utf-8?B?YnpLeVd0OGhNbEd0TThGNlVEbitRclk4dk5sK2RrcFRJK1ZFcFd4NGk2bGpr?=
 =?utf-8?B?bjdYR25JeGJQT2dZNDR4MUNUbEdDUWlhVVVsUkYzUllqYU1TUDF5Sy9pREVv?=
 =?utf-8?B?YjdMR2Y4azY4dzNFZHY4N1VoODJDSFU5VWFzc1NPSW9WZkhTelQ1Ym4weDhG?=
 =?utf-8?B?Z3VwOU04OUlEZm9PR05YZHhsZVkxVHNOck9iZ2ptTUhkMlkxRlM3MXZyUlRI?=
 =?utf-8?B?Nnd4N0NDVE8wVTQxaExCTm44bCtDYTlScEdiZWpnQWdSRTNDVnVaQkhCb1VE?=
 =?utf-8?B?MzVESGlrRlJmb1BXYlZOZytFUGpsaEJkUXpReU9MTzBDeXpBZnlUbUtlZ0dZ?=
 =?utf-8?B?SjhHb0VCSTNUaHNmcUlNbHV0V0FCQVR4RGdqZytxWUF1azFUSmtkblU4NDEx?=
 =?utf-8?Q?YUGyuHsAdUFfZKInHo6RP4SGn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F3AE698EF8E7444B8D7BDEBF0EBAC2B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SkpKdnQ2T2VrM2tDYTRLZ0pJTk53K3Jhc09TTU1xT3NTc3Y1bU9JV2Vsb21X?=
 =?utf-8?B?cC85bmRJcnJWTE9JVy9YV09FcGU3a0ZKaTFpbGJWdTQwaHAzQ1d0ajF4Rzl6?=
 =?utf-8?B?cXNieWZJVkJKQis5SmdVa3UrbzZmU0tvZkFYZm13TXRBazA4L3JFQ0pBdXFo?=
 =?utf-8?B?NzRMM1pFTXhac0g2NUpUZW9HV3dzdzEyVVl6Z01vbWNwM3doTFNjL2RPWVJ3?=
 =?utf-8?B?OS9XcGcxKzdaQ1lBdnJCSXBhNzlNVC9EMEVRTVpPVnhqZ2lhWFVhdG51emFT?=
 =?utf-8?B?eVNPTWNSMnJjRGRRdExFNGhHaVFQOGxDc1dDK2lIZ0ZxaHRiMHJuWkRzQi9C?=
 =?utf-8?B?cEVEd1p1RmgxcXpwdDZwbnZPd0JXNGhmaVZ6ZVdtMFVlNmkyZ0o0Z2FzK1Jv?=
 =?utf-8?B?L2UyMXJvaWVHUFFWSnhabDBZRlJjN2hPRWE4dk1VL2pWR1NhNWFrVzJTc0M5?=
 =?utf-8?B?VVhESS9HNDZCeElXWXRFRFpvcWRjTHFTUGdCTlMvbXlJbDRFQ0YrVWgxdUl2?=
 =?utf-8?B?ZnVMV3U4cTYrbVFKV2E0RCtwcEE4YmRvVjNXbGd0VTR2dzVkNVRtRU9EanRi?=
 =?utf-8?B?Vks0dW1XaWs1L3dyM0dXVEhHOWI4NmZpVWVtU2piYndIdXpOcDhIRCs5R0Ri?=
 =?utf-8?B?R0JrMVJsNDVNU0loc3JwZ20zemdQMzZZYm5SOVNOZENJS2Ewb3lkN0xDOFpm?=
 =?utf-8?B?RHNUQTlrUjg2eERDUTQvNUh6Rm90bE11akw4d0lCdllDU3NJam5VSThObmpa?=
 =?utf-8?B?bjc2b09pdmJseEIyNnBXNkJyZXk2c1RmSmJxL2xoblI3b1NRTk1yei9NMVNJ?=
 =?utf-8?B?dzV3ejZRNktDbm5Ga0t0dUE3cEh0UWd0NUluUjh1VzM5VGJrNG1KTGtqMWMr?=
 =?utf-8?B?blYwejVLaFRneGRScDhOd3Ftdmh0a2pFdEJFRGZwZU9sNDJLQ1JSRmJHS0V6?=
 =?utf-8?B?bFE2ZFRqNkVTQ2JIVmVMSWw5WldqR0dmU2NoTGZOK0Y4b1hTNGRMUXovUzho?=
 =?utf-8?B?WkhTNDBWU09uUkdKK1hpdVRoRlp4aEszd0JGeitJMGJCZGdCRjM4NUJ1dmpp?=
 =?utf-8?B?dFY0WUFNL29EK3pMbFRNd09DY0NLWDNjY2YyNHgySjVtRjE2bnFLYjJxaHpq?=
 =?utf-8?B?a0FITnpUK0s3eDZWejQ0a0IvZmd4b3NFcFg4Y05vTmEvR0tOVlZxSmgrUGlM?=
 =?utf-8?B?Z1JZR2M4dVNQa3MwcEdoZnVOWWtkZTdSb3VUMWppUTQ1Qjh2UytzOGw0WFY3?=
 =?utf-8?B?SDZWWEtPVWlHOFZEcVN5YjNBc2NvOTQ1VkFNZnNYa2RQUURSOUI2Ym03NDdl?=
 =?utf-8?B?RHNBT3BBOUZiZmUwM2FqNTg4T0NQZGJocU05eUNlc1oxYXhjUXlxVFdCSmFW?=
 =?utf-8?B?QkhpZXZTSVM3RkE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049cfe8c-d483-494b-c56f-08db74374289
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 22:14:49.0990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZY1XwubgV9MMCRIBnij6YyicmNHCSSYVHuPdQ/uTLef+qEyiVqQYuRs9jAnUGpa/wTEwpC3yPHtSxm62hMaPgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
X-Proofpoint-ORIG-GUID: _kN6rnh95XswZksmR2kjzXe9ximQgWCX
X-Proofpoint-GUID: _kN6rnh95XswZksmR2kjzXe9ximQgWCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBob3N0LW9ubHkgY2FwYWJsZSBEV0MzIGNvbnRyb2xsZXJzIHN1cHBvcnQgTXVsdGlwb3J0Lg0K
PiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9ubHkgY29udHJv
bGxlcnMgYW5kIHBhcnNlDQo+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJlZ2lzdGVycyB0
byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiB1c2IzIHBvcnRzIHByZXNlbnQgb24g
bXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXQgbGVhc3QgSFMNCj4gY2Fw
YWJsZS4NCj4gDQo+IFRoZSBwb3J0IGluZm8gZm9yIHVzYjIgYW5kIHVzYjMgcGh5IGFyZSBpZGVu
dGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+IGFuZCBudW1fdXNiM19wb3J0cy4gVGhlIGludGVu
dGlvbiBpcyBhcyBmb2xsb3dzOg0KPiANCj4gV2hlcmV2ZXIgd2UgbmVlZCB0byBwZXJmb3JtIHBo
eSBvcGVyYXRpb25zIGxpa2U6DQo+IA0KPiBMT09QX09WRVJfTlVNQkVSX09GX0FWQUlMQUJMRV9Q
T1JUUygpDQo+IHsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19waHlbaV0sIFBI
WV9NT0RFX1VTQl9IT1NUKTsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2VuZXJpY19waHlb
aV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gfQ0KPiANCj4gSWYgbnVtYmVyIG9mIHVzYjIgcG9y
dHMgaXMgMywgbG9vcCBjYW4gZ28gZnJvbSBpbmRleCAwLTIgZm9yDQo+IHVzYjJfZ2VuZXJpY19w
aHkuIElmIG51bWJlciBvZiB1c2IzLXBvcnRzIGlzIDIsIHdlIGRvbid0IGtub3cgZm9yIHN1cmUs
DQo+IGlmIHRoZSBmaXJzdCAyIHBvcnRzIGFyZSBTUyBjYXBhYmxlIG9yIHNvbWUgb3RoZXIgcG9y
dHMgbGlrZSAoMiBhbmQgMykNCj4gYXJlIFNTIGNhcGFibGUuIFNvIGluc3RlYWQsIG51bV91c2Iy
X3BvcnRzIGlzIHVzZWQgdG8gbG9vcCBhcm91bmQgYWxsDQo+IHBoeSdzIChib3RoIGhzIGFuZCBz
cykgZm9yIHBlcmZvcm1pbmcgcGh5IG9wZXJhdGlvbnMuIElmIGFueQ0KPiB1c2IzX2dlbmVyaWNf
cGh5IHR1cm5zIG91dCB0byBiZSBOVUxMLCBwaHkgb3BlcmF0aW9uIGp1c3QgYmFpbHMgb3V0Lg0K
PiANCj4gbnVtX3VzYjNfcG9ydHMgaXMgdXNlZCB0byBtb2RpZnkgR1VTQjNQSVBFQ1RMIHJlZ2lz
dGVycyB3aGlsZSBzZXR0aW5nIHVwDQo+IHBoeSdzIGFzIHdlIG5lZWQgdG8ga25vdyBob3cgbWFu
eSBTUyBjYXBhYmxlIHBvcnRzIGFyZSB0aGVyZSBmb3IgdGhpcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgOSArKysrKysN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5k
ZXggZjY2ODliNzMxNzE4Li4zMmVjMDVmYzI0MmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0zOSw2
ICszOSw3IEBADQo+ICAjaW5jbHVkZSAiaW8uaCINCj4gIA0KPiAgI2luY2x1ZGUgImRlYnVnLmgi
DQo+ICsjaW5jbHVkZSAiLi4vaG9zdC94aGNpLWV4dC1jYXBzLmgiDQo+ICANCj4gICNkZWZpbmUg
RFdDM19ERUZBVUxUX0FVVE9TVVNQRU5EX0RFTEFZCTUwMDAgLyogbXMgKi8NCj4gIA0KPiBAQCAt
MTc2Nyw2ICsxNzY4LDUyIEBAIHN0YXRpYyBpbnQgZHdjM19nZXRfY2xvY2tzKHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19yZWFk
X3BvcnRfaW5mbyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXZvaWQgX19pb21lbSAqYmFz
ZTsNCj4gKwl1OCBtYWpvcl9yZXZpc2lvbjsNCj4gKwl1MzIgb2Zmc2V0ID0gMDsNCj4gKwlpbnQg
cmV0ID0gMDsNCj4gKwl1MzIgdmFsOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBSZW1hcCB4SENJIGFk
ZHJlc3Mgc3BhY2UgdG8gYWNjZXNzIFhIQ0kgZXh0IGNhcCByZWdzLA0KPiArCSAqIHNpbmNlIGl0
IGlzIG5lZWRlZCB0byBnZXQgcG9ydCBpbmZvLg0KPiArCSAqLw0KPiArCWJhc2UgPSBpb3JlbWFw
KGR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsDQo+ICsJCQkJcmVzb3VyY2Vfc2l6ZSgmZHdj
LT54aGNpX3Jlc291cmNlc1swXSkpOw0KPiArCWlmIChJU19FUlIoYmFzZSkpDQo+ICsJCXJldHVy
biBQVFJfRVJSKGJhc2UpOw0KPiArDQo+ICsJZG8gew0KPiArCQlvZmZzZXQgPSB4aGNpX2ZpbmRf
bmV4dF9leHRfY2FwKGJhc2UsIG9mZnNldCwNCj4gKwkJCQlYSENJX0VYVF9DQVBTX1BST1RPQ09M
KTsNCj4gKw0KPiArCQlpZiAoIW9mZnNldCkNCj4gKwkJCWJyZWFrOw0KPiArDQo+ICsJCXZhbCA9
IHJlYWRsKGJhc2UgKyBvZmZzZXQpOw0KPiArCQltYWpvcl9yZXZpc2lvbiA9IFhIQ0lfRVhUX1BP
UlRfTUFKT1IodmFsKTsNCj4gKw0KPiArCQl2YWwgPSByZWFkbChiYXNlICsgb2Zmc2V0ICsgMHgw
OCk7DQo+ICsJCWlmIChtYWpvcl9yZXZpc2lvbiA9PSAweDAzKSB7DQo+ICsJCQlkd2MtPm51bV91
c2IzX3BvcnRzICs9IFhIQ0lfRVhUX1BPUlRfQ09VTlQodmFsKTsNCj4gKwkJfSBlbHNlIGlmICht
YWpvcl9yZXZpc2lvbiA8PSAweDAyKSB7DQo+ICsJCQlkd2MtPm51bV91c2IyX3BvcnRzICs9IFhI
Q0lfRVhUX1BPUlRfQ09VTlQodmFsKTsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCWRldl9lcnIoZHdj
LT5kZXYsDQo+ICsJCQkJIlVucmVjb2duaXplZCBwb3J0IG1ham9yIHJldmlzaW9uICVkXG4iLA0K
PiArCQkJCQkJCW1ham9yX3JldmlzaW9uKTsNCj4gKwkJfQ0KPiArCX0gd2hpbGUgKDEpOw0KPiAr
DQo+ICsJZGV2X2RiZyhkd2MtPmRldiwgImhzLXBvcnRzOiAldSBzcy1wb3J0czogJXVcbiIsDQo+
ICsJCQlkd2MtPm51bV91c2IyX3BvcnRzLCBkd2MtPm51bV91c2IzX3BvcnRzKTsNCj4gKw0KPiAr
CWlvdW5tYXAoYmFzZSk7DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
dCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3Ry
dWN0IGRldmljZQkJKmRldiA9ICZwZGV2LT5kZXY7DQo+IEBAIC0xNzc0LDYgKzE4MjEsNyBAQCBz
dGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAl2
b2lkIF9faW9tZW0JCSpyZWdzOw0KPiAgCXN0cnVjdCBkd2MzCQkqZHdjOw0KPiAgCWludAkJCXJl
dDsNCj4gKwl1bnNpZ25lZCBpbnQJCWh3X21vZGU7DQo+ICANCj4gIAlkd2MgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKmR3YyksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghZHdjKQ0KPiBAQCAt
MTg1NCw2ICsxOTAyLDIwIEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgCQkJZ290byBlcnJfZGlzYWJsZV9jbGtzOw0KPiAgCX0NCj4gIA0K
PiArCS8qDQo+ICsJICogQ3VycmVudGx5IG9ubHkgRFdDMyBjb250cm9sbGVycyB0aGF0IGFyZSBo
b3N0LW9ubHkgY2FwYWJsZQ0KPiArCSAqIHN1cHBvcnQgTXVsdGlwb3J0Lg0KPiArCSAqLw0KPiAr
CWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCk7
DQo+ICsJaWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVfSE9TVCkgew0KPiArCQly
ZXQgPSBkd2MzX3JlYWRfcG9ydF9pbmZvKGR3Yyk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlnb3Rv
IGVycl9kaXNhYmxlX2Nsa3M7DQo+ICsJfSBlbHNlIHsNCj4gKwkJZHdjLT5udW1fdXNiMl9wb3J0
cyA9IDE7DQo+ICsJCWR3Yy0+bnVtX3VzYjNfcG9ydHMgPSAxOw0KPiArCX0NCj4gKw0KPiAgCXNw
aW5fbG9ja19pbml0KCZkd2MtPmxvY2spOw0KPiAgCW11dGV4X2luaXQoJmR3Yy0+bXV0ZXgpOw0K
PiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5oDQo+IGluZGV4IDhiMTI5NWU0ZGNkZC4uNDJmYjE3YWE2NmZhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaA0KPiBAQCAtMzMsNiArMzMsMTAgQEANCj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L3Bv
d2VyX3N1cHBseS5oPg0KPiAgDQo+ICsjZGVmaW5lIFhIQ0lfRVhUX1BPUlRfTUFKT1IoeCkJKCgo
eCkgPj4gMjQpICYgMHhmZikNCj4gKyNkZWZpbmUgWEhDSV9FWFRfUE9SVF9NSU5PUih4KQkoKCh4
KSA+PiAxNikgJiAweGZmKQ0KPiArI2RlZmluZSBYSENJX0VYVF9QT1JUX0NPVU5UKHgpCSgoKHgp
ID4+IDgpICYgMHhmZikNCj4gKw0KPiAgI2RlZmluZSBEV0MzX01TR19NQVgJNTAwDQo+ICANCj4g
IC8qIEdsb2JhbCBjb25zdGFudHMgKi8NCj4gQEAgLTEwMjksNiArMTAzMyw4IEBAIHN0cnVjdCBk
d2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICogQHVzYjNfcGh5OiBwb2ludGVyIHRvIFVTQjMg
UEhZDQo+ICAgKiBAdXNiMl9nZW5lcmljX3BoeTogcG9pbnRlciB0byBVU0IyIFBIWQ0KPiAgICog
QHVzYjNfZ2VuZXJpY19waHk6IHBvaW50ZXIgdG8gVVNCMyBQSFkNCj4gKyAqIEBudW1fdXNiMl9w
b3J0czogbnVtYmVyIG9mIFVTQjIgcG9ydHMuDQo+ICsgKiBAbnVtX3VzYjNfcG9ydHM6IG51bWJl
ciBvZiBVU0IzIHBvcnRzLg0KPiAgICogQHBoeXNfcmVhZHk6IGZsYWcgdG8gaW5kaWNhdGUgdGhh
dCBQSFlzIGFyZSByZWFkeQ0KPiAgICogQHVscGk6IHBvaW50ZXIgdG8gdWxwaSBpbnRlcmZhY2UN
Cj4gICAqIEB1bHBpX3JlYWR5OiBmbGFnIHRvIGluZGljYXRlIHRoYXQgVUxQSSBpcyBpbml0aWFs
aXplZA0KPiBAQCAtMTE2OCw2ICsxMTc0LDkgQEAgc3RydWN0IGR3YzMgew0KPiAgCXN0cnVjdCBw
aHkJCSp1c2IyX2dlbmVyaWNfcGh5Ow0KPiAgCXN0cnVjdCBwaHkJCSp1c2IzX2dlbmVyaWNfcGh5
Ow0KPiAgDQo+ICsJdTgJCQludW1fdXNiMl9wb3J0czsNCj4gKwl1OAkJCW51bV91c2IzX3BvcnRz
Ow0KPiArDQo+ICAJYm9vbAkJCXBoeXNfcmVhZHk7DQo+ICANCj4gIAlzdHJ1Y3QgdWxwaQkJKnVs
cGk7DQo+IC0tIA0KPiAyLjQwLjANCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
