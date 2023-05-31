Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC997718F05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjEaXUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEaXUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:20:15 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515298;
        Wed, 31 May 2023 16:20:14 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLH0fx004608;
        Wed, 31 May 2023 16:20:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=azcvjehXvfM8LLchG9WMad2fW/jaSJnK4nWeMuMTRnY=;
 b=cI3emYOgZs53EaUSvH/1zxMFto9bxprnotF/EyGDj5uaYwLVbZuc+ceeXHOv5sfV1noh
 mPVbhyiCNfkf+8KzdhcYiCzevbTQh3oNShsFw8lcLKUEKd+0FAqczInlvqApg3XQyjIA
 syhbJgUJYaKvBoHQvUVZG91f7NpT8/NRdhV82RnBN0JAqqb5OztWsxWda6bHI2XnlIDQ
 n48cHBtu0W7Ok+jOgfRzPdeXFgQjVjQP7Y295Wd4FbKxOTViLVcRcu2dqGDizwRHKnly
 WzzI1hjTH5tXJR+VRc31W85YVRejQyuRpjwKhKB1QOtrLm/fW9KxGjuvG+9yI2EhyqMW qA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qugsu5q3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 16:20:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1685575209; bh=azcvjehXvfM8LLchG9WMad2fW/jaSJnK4nWeMuMTRnY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WNh8N6r+wgEDndYN11SsYgy/bNwsvl5V0Al5oOo67w8E6gdb9/6bf4LqLxf2ir6mW
         tbAabwsFNaJZ6QsjNuHodSr8InyDoSqdTRgwcwdKmhNMWItxBsn9qusOgkJachpU19
         ZoqtwdvLnVDgQhCCf+E48L90oMQl2r9hyf8Y/7zVNDHKZ0K21F6RWtj2pddHxgSwOk
         GcRXikivgtvejLpMcJa845tXJx+BKycxjYFuLM15PWXOyeyLXMg67c4AjLxJ5nq0tG
         j0MZ4dVnHr64JFLBdKXk8jiA8DFjyf54AwATaDykQyshZ/ooeI4Runi6VcPNLf04ks
         4AwZuL5jBM9qQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8DB7C40737;
        Wed, 31 May 2023 23:20:09 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DA992A0073;
        Wed, 31 May 2023 23:20:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dVt9loHE;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B88340145;
        Wed, 31 May 2023 23:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYsGwEkpzMyDaTRSKhecKAxZXm/unGz+e+dJtpzlYKcI4Px5N3KnTlTUU9yMXiIyLQWxP+8mejZA6ZUeYQ+SRUALNtnDUCE1gptg/WBTYOam4kV05F56coc5O8qLYy5eiocWG/jorhHNMRDOYc71qTGg5y8spSYZ2Kvo/D90TGX+U29oyu04yNfHVOJG3GM9bePO0WooyjHSfCCs+vRivpy2kETIteJMV7wDll80yNR2Z4HhBEeIiu0JX7SNPp06JE16FLieqecB7a00HMJJCtNU18Qud//ITiYNudeHiuVy5I5gZh7syHYsHLWEWfZto5KrnZNOFWzUF6t2/TKJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azcvjehXvfM8LLchG9WMad2fW/jaSJnK4nWeMuMTRnY=;
 b=cVOYDZ7ntS0eZa0p0oBdUdaybkI5ALcwueHJvbSGEk0x0Xbl02nQESHAdriQXniDd5mjc0bLg+WzgblCxBXHxRATE+nxXwTN3FpOBddPhdTpsDRNKxO9v3/vjvcPF772mbenDB2lMxhyhXigADua+qgOFspH8UQEZLoN8oIwwv/OumsI46W0Prsy73EughdGDcMexY949m5cQ8NC2dS7yniJISm8HLzUs620Gcf9iwa5GCdpEUSwFSQGiR4uKtyToRYvTXfyfrffrTD88fjDz387z/vOus8NQZ8KrTKXt8dpIOheiJFMZuEndf2DixtDy7wrQLJs8rFllniYrc25WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azcvjehXvfM8LLchG9WMad2fW/jaSJnK4nWeMuMTRnY=;
 b=dVt9loHEmqttQ5diUwMYJSShirud/pXC03FUOqDaFbYowXMT2mY6PnHxWTwgNk+phzveAyZI8pDysMgXGrpG/J9NwTBczhH6IvyAxhfZeq7PfOBNyzyZJ98w07h6OlZQoz1R6v15Kf5tr/xwnSb1gy6ACN67h1mmahquf8PjHxU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 23:20:03 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 23:20:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: Skip TRBs while removing requests in
 disconnect path
Thread-Topic: [PATCH] usb: dwc3: Skip TRBs while removing requests in
 disconnect path
Thread-Index: AQHZk/nVxQI+NeMmWkCDLCh1fe8pO691BNiA
Date:   Wed, 31 May 2023 23:20:02 +0000
Message-ID: <20230531231951.vg7x2w7gnnm77alq@synopsys.com>
References: <1685562871-17024-1-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1685562871-17024-1-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB8612:EE_
x-ms-office365-filtering-correlation-id: adbf8fd0-1a08-4e1f-4b7b-08db622d8fd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QekTR8MZTYQ7Zx1n4RgD1iT9bASHTOkQ+VC+r2Kow4o1mhJ0X+XHs2NIYeOtWWWkNttHA2Lu4NzK7V1WgimMMlw1hoCjBPly7mM61/IwmAt52EqCFvbNi3j3WZYIztEVPMyJ8LXyx+zR7chsrOSVE4AtGmCQSYFRNoMfwYZKUvnMLwK8CNyLBZylPkfIyn6ViehmrpWlQi5QoZvUroOQZtteLOxSys9JVvj8rEOBAe++zES7YoZENp37Eyc9P+lAUs1J2eHn9Fz7eIer1eknDilZ/c33/aLWx/IdLdFwXz12Idchk6jgICPr3NVCIz6TE/ZhRJDYh4VG2ankKTtYdjxR7iUlt22RnnhW0BEQMaorLiU6JPblmzj6mMBUDD2oN3Wb4Z2vair9QvpD99lWPu6UrgBMn4OQUoc9WjJhl44aLox+pVhVRYej8g7IxlQbA3aR6bWX58zRd4ROh4TTI4abIjM26V5O1a980vGjX3NDLIUOThhMh2aC1CwgEuHJI8cK4yJRe5JtVjDsLP259OMwjH71AmXZq30PUemv+ta44SjcO+E/TeFni0NI31zcmo88p5O9zXuP9WbsIyin3XzW9Y+51do4lb6XS4qKapLjapjKMklvrjjMphyQwi3l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(54906003)(71200400001)(478600001)(8676002)(5660300002)(2906002)(86362001)(36756003)(38070700005)(8936002)(76116006)(64756008)(66446008)(6916009)(66946007)(4326008)(66476007)(66556008)(316002)(122000001)(41300700001)(38100700002)(2616005)(186003)(1076003)(26005)(6486002)(6506007)(6512007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3E5NVJ3eGRjWWZHeGJKekZQamxLbExiVVVYMGtBY2xmc0xXeFZHR0NyY3lQ?=
 =?utf-8?B?U0RuREIxV0ZQV0YzRm1hWVdsODJBSENFOGVmbkprMnAzKzM5Mjk5NHNoYk52?=
 =?utf-8?B?TUMxaHpRby9Td3RuSksvZm12aVp4WFJCb3RFeGxQZ0V0VE5rV0pZVjlDeFlT?=
 =?utf-8?B?cGlQWGJrSkkwbDE2L24wYlpOdFBFTEZvZUgxT1o1U3JnNXlFaTZTRjBUMnZw?=
 =?utf-8?B?aVVCemwySGZHYXFRUjJGTjFyc1JuOWFnSzZkTFFUTGQ3VVNBQWc4S2tWRzRK?=
 =?utf-8?B?WU41SmJSbms4VWc3c0RmMzJUbldDam1iSFhEK09xNlhocW5OUlZvL05sT1Nh?=
 =?utf-8?B?YTM0bldWMWZMVEJCekFUVGdKWldyZkttT3dnQ0hUa2FqYW54c0VFdjY2eFhL?=
 =?utf-8?B?MFBDUkF3amVBM25oYThhVkhPR2Zlb0dyOUVOMnRXYW5uTGRURCt3a2dNbTU1?=
 =?utf-8?B?N1dpc1luVkVLODdBSnUxQ0RveGdhS1UrdDR0aDZkclNBT1VrbFpqWE9ZVDRu?=
 =?utf-8?B?WGdRU3dva3VjL2gwUDJRZmxnZU54QUJDb2lHV0ZURG1RUlhmdmwvRGJaU2NB?=
 =?utf-8?B?RUtyb2F2QUI3MjdSOWtLc1h3eWRnaGpJdXdEYU9KUm11NW1GTWdSbm9GeGJ3?=
 =?utf-8?B?NERoZ2RtUnhFQjR4RGxsQ3U4ZEVJb2Rhank1Nm1JdmkyRUpzeVBiWGNSOTdZ?=
 =?utf-8?B?cHk2Y05aZk9NeVhiMVVMbkRZYmlxckFKcUtBSXMwTmY1REsvenBEeTEvQmxr?=
 =?utf-8?B?dkhOaC84Ly9mdUlUWXpueC9hakVrc1NtSmhveDRGL2VLbk9XY2FjY1k4ZWFm?=
 =?utf-8?B?WU5QaUZFSmM4T0JObWNNdzUySTRpczhZRXdmcjMzOVIrcW41THlwS0JYY1Rz?=
 =?utf-8?B?MktORG9hQ09JMUtuUlBxempSaEJJVmtNQms2K3lKM0E3Qy9KYVZPeE51WXFH?=
 =?utf-8?B?Rm9EYjB0cWZveXRYT21HeVVnWHM4SENrR0taVFMxTjVna1VqZXpkU0F5RXh6?=
 =?utf-8?B?TVYyL3Y1MU44RmhvdWVkU1lMQnVIdXBIbTZyclN3OHVXczhIanJ5UWs2aERZ?=
 =?utf-8?B?VG5McEdhZnFIbHQyeTFhMUFzL0xTSDhlZjBBcE0xYThZWG4zVy93S2NlbGRY?=
 =?utf-8?B?TmJONjR4WWtlR2JoMVk3ZlpPNk8rU3FrUnpnRHRqUjZKaDZIWXBsZjRMWmY3?=
 =?utf-8?B?cEJJMG5OWEVES1FSR2FWU2hYczg2ZUtTOEdTRTJDZ0d1WTRiMmc0MXBjUnBK?=
 =?utf-8?B?MUdGNXR3R251TFJSNm5WQU5jcER4OENEb1UyTHcrQ3ZkS3dyb3Y2U0poWFd6?=
 =?utf-8?B?VC8rbDc1WkdickJ2eTNNZklPOUMrMWZ0cnFLTFd5YnNCd3MyOUNjdDl1YlFw?=
 =?utf-8?B?UnFwa01SelhJaW1uRHA3S0xUbTFvc09FRzlyM0U5VDJvLy9ybFNtalQrTVpO?=
 =?utf-8?B?NlcwOTB6RXFTTjBOYnZZZkFUb05PWWtsZ0RCM1pmeWlnc3d4MVdDY3pobHMv?=
 =?utf-8?B?OVkrSzJqUWZPQktYWXZGM3hzVnE5RExjNTZCbk8zaXBDMmZTNC9GNUNTT2lD?=
 =?utf-8?B?b0N2L0l6bk5sNHFjNUN3Rm5UQlhOK1JGK1A2b3JvSnU2MjJBc0pUN2ZKeU5w?=
 =?utf-8?B?YjRlN0VWeE5BYTNDMXFlWGNnQW1CVWRONC9LbVdXQ1laZlFIN0xNRmFIY2xz?=
 =?utf-8?B?MitaQWpycFFHNVV6Q0dxT0NGWjN1eEpEa3MrK1V1N0c2MFhjUVBLM2d0ZWpu?=
 =?utf-8?B?VTREZEUyNXdsOStRbDMwT0U0NjFjMUxITGl5OGdCWXlNdS9Obmg0aHN4L1RF?=
 =?utf-8?B?S2Q0UzJmRHR0VERwZjl6MFVrOEdXTEpGQXZ3cjJKWXJDL1N4RXZnVk54SDRE?=
 =?utf-8?B?QTBLSE4wNlNkRnRWR1hlSSs1M1lWc3p2WG5yREN2R1BrR2pzaU9vNER1UVlP?=
 =?utf-8?B?RDJlQXNWS1FBTDk2WU9DanBhcUZDaTVXS1BxOWt2bGpCOXBoWWtOdnk0VVIv?=
 =?utf-8?B?a0ZkNXNDVG8raXZoazRiSlRwSzVHdVhCa2pGN2ExdmxidW1ieENUWG4zMW00?=
 =?utf-8?B?R1d6NnE0UmYrWnRuOGVkRjZxSTRKNG9SUzkycWcxWUJ4THFQN2dPbTFiUUhQ?=
 =?utf-8?Q?Pubc2tSwXUJC/oIv+k8f7zI4i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B0237DBC53FDC479256F62640351D2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kp+rNpUhVSLiPqhfp4UTzgRdZKKhohRotGadj3vRsOHR6WSowxe3TghzFI2uhigooDrIsDuAQPgiZgvwj+gf9CgT9zl2awCXiyTvosThqge3c9ep9SN1quDudTRXAg7vhjyxHpnn5SnMyvTAoPY61qcf+x7rRyb2Y3DUVKntTF9o5elk1F8K+O1KQXJvsteoLyEuTYwPfu9OOCv3E4bJr0GhJejVkvXhGIxb7/I4nsACJm6OK98ASWKyxcUxWkEV2+xwvnoq3pBubglq+5eE1PX6QcpKv9TorvUHTANa40O2pUwYLz3lTI8/9bYZVrz9yJY3A3dHW9I4p0wfvH0B6ENoRslgD5VF8fsubPXFveMkNowy6Lj1YHalbH6I0sdN0klhbWub+TMPLWd+vOktiOFouz4u57pZueL/EoMpHHgIMc+k4y69ZXKMSgxDV26J0MyVE8BKQL7kHFc5fHItjhU4cYz0Lpf3PJw+DBwiKPbSh8hVQhucpJ0Oc04JmdvU/oxYiXn5wzjQUSOpoYbDvbI2ymZGa5QRFnYWk0gnf5RzTJxhbcJ5phYWcP0bqYBLp6QYJUxRVRl+Ne4lDKr8l4r+4h9BJKMK5aKHyJsrvoMCNXQFQ9jd7YCnREwcZR6DTfxlBoMYCDUMSRFmoLpDNf/nS/l7N4krg+dsCMEgjQG/dK3zDaN21ohymmjbu+/Abw3uJbCWdCEzVfE/EmMwVIpiWdzDrnlnrubnNTr/pRUklXIsr/eJbIs6d7fGBrFWH+ma1lfkV/YUoDjzxJg6+SywwfaNczxkHPGS30ZJyo16AWwvrMQYEXR8OWwS2rZTH+DaG4GJ6bClVDfPyYIHJkR21AFpePYtK83dnvDU7EFnBa6tjs3W1ajGskPp8Q59jjncl9Id/7fnm10PQyeXBg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbf8fd0-1a08-4e1f-4b7b-08db622d8fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 23:20:02.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4d4xb1BGVMwr8/s0k76lpo8FG+5JVhAnUb22ZRFCX+pkDi1hVkxWL0FpBeNMKro45lIKW+1V28E1MQW5o9EX8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
X-Proofpoint-GUID: rM9_kw3WcLCe15AbTr4TzABVWNL3DR-S
X-Proofpoint-ORIG-GUID: rM9_kw3WcLCe15AbTr4TzABVWNL3DR-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_17,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=974 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMzEsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IENvbnNpZGVy
IGEgc2NlbmFyaW8gd2hlcmUgY2FibGUgZGlzY29ubmVjdCBoYXBwZW5zIHdoZW4gdGhlcmUgaXMg
YW4gYWN0aXZlDQo+IHVzYiByZXFlc3QgcXVldWVkIHRvIHRoZSBVREMuIEFzIHBhcnQgb2YgdGhl
IGRpc2Nvbm5lY3Qgd2Ugd291bGQgaXNzdWUgYW4NCj4gZW5kIHRyYW5zZmVyIHdpdGggbm8gaW50
ZXJydXB0LW9uLWNvbXBsZXRpb24gYmVmb3JlIGdpdmluZyBiYWNrIHRoaXMNCj4gcmVxdWVzdC4g
U2luY2Ugd2UgYXJlIGdpdmluZyBiYWNrIHRoZSByZXF1ZXN0IHdpdGhvdXQgc2tpcHBpbmcgVFJC
cyB0aGUNCj4gbnVtX3RyYnMgZmllbGQgb2YgZHdjM19yZXF1ZXN0IHN0aWxsIGhvbGRzIHRoZSBz
dGFsZSB2YWx1ZSBwcmV2aW91c2x5IHVzZWQuDQo+IEZ1bmN0aW9uIGRyaXZlcnMgcmUtdXNlIHNh
bWUgcmVxdWVzdCBmb3IgYSBnaXZlbiBiaW5kLXVuYmluZCBzZXNzaW9uIGFuZA0KPiBoZW5jZSB0
aGVpciBkd2MzX3JlcXVlc3QgY29udGV4dCBnZXRzIHByZXNlcnZlZCBhY3Jvc3MgY2FibGUNCj4g
ZGlzY29ubmVjdC9jb25uZWN0LiBXaGVuIHN1Y2ggYSByZXF1ZXN0IGdldHMgcmUtcXVldWVkIGFm
dGVyIGNhYmxlIGNvbm5lY3QsDQoNCldoeSB3b3VsZCB3ZSBwcmVzZXJ2ZSB0aGUgcmVxdWVzdCBh
ZnRlciBhIGRpc2Nvbm5lY3Q/IFRoZSByZXF1ZXN0IGlzDQphc3NvY2lhdGVkIHdpdGggYW4gZW5k
cG9pbnQsIGFuZCBhZnRlciBkaXNjb25uZWN0LCB0aGUgZW5kcG9pbnQgaXMgbm8NCmxvbmdlciB2
YWxpZC4gU2hvdWxkbid0IHRoZSByZXF1ZXN0IGJlIGZyZWVkIHRoZW4/DQoNCkJSLA0KVGhpbmgN
Cg0KDQo+IHdlIHdvdWxkIGluY3JlYXNlIHRoZSBudW1fdHJicyBmaWVsZCBvbiB0b3Agb2YgdGhl
IHByZXZpb3VzIHN0YWxlIHZhbHVlDQo+IHRodXMgaW5jb3JyZWN0bHkgcmVwcmVzZW50aW5nIHRo
ZSBudW1iZXIgb2YgVFJCcyB1c2VkLiBGaXggdGhpcyBieSBpbnZva2luZw0KPiBza2lwX3RyYnMo
KSBpbiB0aGUgZXAgZGlzYWJsZSBwYXRoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWxzb24gUm95
IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA1Nzg4MDRkLi5iNDVlOTE3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gQEAgLTk4Niw2ICs5ODYsOCBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRf
ZXBfZW5hYmxlKHN0cnVjdCBkd2MzX2VwICpkZXAsIHVuc2lnbmVkIGludCBhY3Rpb24pDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VwX3NraXBf
dHJicyhzdHJ1Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEpOw0KPiAr
DQo+ICB2b2lkIGR3YzNfcmVtb3ZlX3JlcXVlc3RzKHN0cnVjdCBkd2MzICpkd2MsIHN0cnVjdCBk
d2MzX2VwICpkZXAsIGludCBzdGF0dXMpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNfcmVxdWVzdAkJ
KnJlcTsNCj4gQEAgLTEwMDAsNiArMTAwMiw3IEBAIHZvaWQgZHdjM19yZW1vdmVfcmVxdWVzdHMo
c3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCwgaW50IHN0YXR1cykNCj4gIAl3
aGlsZSAoIWxpc3RfZW1wdHkoJmRlcC0+c3RhcnRlZF9saXN0KSkgew0KPiAgCQlyZXEgPSBuZXh0
X3JlcXVlc3QoJmRlcC0+c3RhcnRlZF9saXN0KTsNCj4gIA0KPiArCQlkd2MzX2dhZGdldF9lcF9z
a2lwX3RyYnMoZGVwLCByZXEpOw0KPiAgCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJlcSwg
c3RhdHVzKTsNCj4gIAl9DQo+ICANCj4gQEAgLTEwMTIsNiArMTAxNSw3IEBAIHZvaWQgZHdjM19y
ZW1vdmVfcmVxdWVzdHMoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCwgaW50
IHN0YXR1cykNCj4gIAl3aGlsZSAoIWxpc3RfZW1wdHkoJmRlcC0+Y2FuY2VsbGVkX2xpc3QpKSB7
DQo+ICAJCXJlcSA9IG5leHRfcmVxdWVzdCgmZGVwLT5jYW5jZWxsZWRfbGlzdCk7DQo+ICANCj4g
KwkJZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKGRlcCwgcmVxKTsNCj4gIAkJZHdjM19nYWRnZXRf
Z2l2ZWJhY2soZGVwLCByZXEsIHN0YXR1cyk7DQo+ICAJfQ0KPiAgfQ0KPiAtLSANCj4gMi43LjQN
Cj4g
