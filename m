Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE274BDAB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGHNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHNhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:37:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2123.outbound.protection.outlook.com [40.107.94.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD24EB;
        Sat,  8 Jul 2023 06:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3PV6ultnDNA98LLTbVj0DiImqOz9HZfa5b5jQ0vSBQJRXCk1shNE03po7f0iWPcm0Q8tr/l4E74V2fxJ4m9ANC28/yWGNZMmaWgx6L1VwZNUL5kGi/IJLUKRF/xnS1KCBQiPE/9lWLdbZVDjdCpIy7nkY934/5Ng/U5Dv49UsUCph6+ZBZHuc2n63S8arhSBx1zDJWbL9t3APJgaAql6G/9TuDGmfecNtvEUj6jqd01DWfPqagihisvZgd/XcP5MvzQz7rK8RXoE3/5E/Cp9W9/0xmwiJYJr7y6QP+/OK5MyPzKbuJgzdzuHMxhkRKHg5b1rybBp/Bvy0RlXUajcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+YJZiI/230AT9dDKfzD+qahnAtBDF5YY4cjusG3m5k=;
 b=C4TQH7FS6v1C6W74NuB5twDuBFnEbMZyEJHhqP9GKOCtAvCs4S8+d3I9A5ZXIOnkO73K50DwIzDDq/k605JHl2WtCaFXUscTdln0+gj1jn/wBMZlBsBDFLlgjKv6yICZuTXv91loNHWwItj38VoS+IMM0UOfDsDNtwbbRKSOfsC5nHquaROZlrfVKHro9Ujj/pX0tQ0OJuGznTqajiDxa6AsJ1/t/FcNikMQsZvpJPx5yVuCVTkcnaJgM+WeCSsaZks/BtQPnHj9+EJtRSv44DTqO/ugOFvzhO3dK1mMcgli+CtkEKJJX+kP+ICjqQSkGpcxbP4XGuqcqGh33WUHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+YJZiI/230AT9dDKfzD+qahnAtBDF5YY4cjusG3m5k=;
 b=IoXsjfOtRZXL0B6J/X0qOR7oiu7AlpzqeIshuRaYNUoKibPAkRq9ZoK3b030JXthSqo7V7UMwWdGuPQLO9F43xwh0pb5Bi3B3sfYRx2jIUj7k3khU4ab8HUC7mTCiP0qhpoHkrs6RSsnC1lhWIkw+iiLvz5PHCxocYeUjnTQ4ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5985.namprd13.prod.outlook.com (2603:10b6:510:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 13:37:04 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 13:37:04 +0000
Date:   Sat, 8 Jul 2023 14:36:56 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
Message-ID: <ZKlmeDUEZf7F8+HW@corigine.com>
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
 <20230707104359.3324039-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707104359.3324039-2-schnelle@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0311.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 9506ae66-5cea-4354-2c5d-08db7fb86a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mz4ZWaTNti8GvSPhmu5tuwbl4SGGhLVp9kgAzZvno3bM7+hZYIK2M/4wWFjTE2/zeFRk3CH69YAgDUqOSoZiUVMGVW6h+jf/VX6tr6pwV4hwGdm1P4L2gLW+134Nxr4fNIW2FwMjMznj2sJa61eRAfuj1Tgt2bTgG4r4jLiHsu1GASaWZ2+22i28hs+Myt7g6J9VPm8SK6TwBdF5VxH4TC5PJEazOYTDnP1WReBU8FMaK/FOj31kymfAqlOr1xj8hsxbtF2RLNu+o5+d25eOcXrO3fss346E7SXgWvgk2futI9IkBvmwir9zCdrlNDi+5mvJIIqyFZHhQv4dclFEpR5VRs/NSpqcCHBYpe8N9SLEBTgJx/TzCCW8l9242aE/nMM38Ohik1wC8tBDKQiHzL1AZCx1vaGzGu1yx0pJ1HSnceZVMJ4mF16/efl1pA0e6hKaiDmB67Ul65jdpwxUnSiduVLvLAm7CDmltxZ8gTFgQMtHirM0eiELGI2kYrp3nKcW45OYnJMa6xp11mCmsfRzMEcyxYav6prcXMRfLoau9bwunmIio+dLpSGweX4tq1+vqn3FTYzxeoP+yNIlyxMcRsqcSV22ek179Kl7qI48rg+qdzCnZ66gzbIhQyY7bCeZuTOsyaL+VzUN95I8lSRAo9nzYMSYTjs+oCZaLPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(396003)(366004)(376002)(346002)(136003)(451199021)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(2616005)(86362001)(186003)(6506007)(26005)(83380400001)(36756003)(478600001)(6512007)(6666004)(6486002)(54906003)(44832011)(41300700001)(7416002)(5660300002)(8676002)(8936002)(2906002)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rCTtjhx8tY0KVaoeEBJyrGACQZIt2LsG1mWxMpBUKmpTIBEP6lbuylYVH99U?=
 =?us-ascii?Q?qNNK1debnoxE02rrTi8ZFopFKtBQSL3IOvcKb/otoXQ6Owwl9qV3cyaWu0mF?=
 =?us-ascii?Q?CsfCDCJpKbA+1AcaWHR8nPcV4ebBhScY43MjPPJXjlxygScxcsSJ4RcKBuZj?=
 =?us-ascii?Q?avUdGKJid9WHJCqq/0gIN2SiiW8sjeOmYdKBTXvHfnnUQGc0k1MEHtAtvBzL?=
 =?us-ascii?Q?ju8MLNQxLxTGVA2hneLzC3ufrcoGoS3kEMFqhHdDPo+KOxKCrq04bI5gNOcC?=
 =?us-ascii?Q?ZKl10hTwNEIFEDmbCb1+cjHywmHRBAvjyx3uPAUWA3rKvXfwZH9tEW8fAHtD?=
 =?us-ascii?Q?tiLe04vazCSLobPaRZK8XiFK6Nl3MklqFRua6+Wwi3S4Zc+85KRLbcdYw/Ka?=
 =?us-ascii?Q?SAlD0gPufFzIrMRaZ5TL7mEbMa4xNhUhzr7YViowyzz3gdJKn+nAxP6lNC8N?=
 =?us-ascii?Q?hWNKlV8ldM3Sa0WLlo7wA5YtDdz59to425Xz7Ht7isYtdGHW6r6JQwKXnsp9?=
 =?us-ascii?Q?zxtR9RQsbdAUrrZEq8llH/d9C1lUdL6lFXjle667JQIdMoJVp5qfI6LDIsRL?=
 =?us-ascii?Q?M2J8A2Qbxc4QKY8I1fajWxoZ5yDHXoORS7VNsKseleMAIPirZhFIVim7UC7a?=
 =?us-ascii?Q?vNoPQuaB0sv8sSogxrIRbpnti44FHejlMzUOMV1wMtK8l82l3KO6YO2TPkpJ?=
 =?us-ascii?Q?DUoDRWGEwIQOBBmOBQbmye/eacWdViPQGhElCw+mr+JuCHpSe0+L9QUaaLWz?=
 =?us-ascii?Q?f4oJ/3EgxOv+p8MrnotERuQRTxHqXr7STf+MziUtf3XAd7lqLCfuEL6HFWeN?=
 =?us-ascii?Q?1U2oveRH+z91PAGvC7Dh1wdE70bU7B0nPrFt+JaNAVQ41wcHvQ9+OTcnAHct?=
 =?us-ascii?Q?y9t2S47fhkUrOH6Xf5NrTaolsgnxdHugYGPzKpfit++9zP7AJtkXKOCzsiKZ?=
 =?us-ascii?Q?NX749Kzq+Tnao9Cw1CdNXas5Aa7myHTNHakkCP58zmEnuFmA4THMEgFFyGzC?=
 =?us-ascii?Q?zLhbSdbOr/FzpvMUgswOqPIAZnhGtraI2eQE4VPoTPJO4ozNpkBFRuD74Lpo?=
 =?us-ascii?Q?hZMtfKMqAvICJy04DvOSt6VWjQxImFLfkg9FlWkQYpzfYyxUrI7SlYy016Jy?=
 =?us-ascii?Q?Vwu8UqlJ3gMeHl4PvEe+b8a4MbME09tA9IADxjtrtyVr2Za0+D/1wCScvY5X?=
 =?us-ascii?Q?JHJBHGo/G0pCfAi2dlKVtWhCrZ/GwKf1IbDOHJ4dHJiw7zyTH9Eq43Es/NkW?=
 =?us-ascii?Q?p5sijN/sbaTFSHqpFYuiTcxDl9bU1Toay8OHdVUdh39bMfRD+t9oSM2mrxBs?=
 =?us-ascii?Q?2yoo3A7ztdb632JhGbNdG3HT9fMC4v4VpMdoXcIN5xhvQQRuF/5gxt8FxcdA?=
 =?us-ascii?Q?wCAUDqacc119CHvl0NHIWfqCDEOWJozIuso6fpIBVb6mgM9TjxfIcc6a90mS?=
 =?us-ascii?Q?HUBUqWA4BDcy82s2xzwO6yJdd8MNn8t5uWBhp2wNUcsXuPTq8SK8F3XdIWyo?=
 =?us-ascii?Q?nFpVS4fw2CveAUVz170UKn3KnFxTwQVuGtaR5VY7YiYq2TmEJl7zlP6SzEcs?=
 =?us-ascii?Q?L0tmhtMMDqQ7OdLVZytvRiHjUcQkPUf2fOyq/wx+35dqFVhdpqQZPtmXcoGt?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9506ae66-5cea-4354-2c5d-08db7fb86a33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 13:37:03.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/wWsTLpdc2bsBIiARXJ2eC+RwdrH5pAAb7exSG6Vz03/BDJEyXpuuwoDaxADKM28Hk32Q8nA+TdGb53KSbeJKeyC0x39zjGy/aiWLk4gWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5985
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 12:43:57PM +0200, Niklas Schnelle wrote:
> The clients array references all registered clients and is protected by
> the clients_lock. Besides its use as general list of clients the clients
> array is accessed in ism_handle_irq() to forward ISM device events to
> clients.
> 
> While the clients_lock is taken in the IRQ handler when calling
> handle_event() it is however incorrectly not held during the
> client->handle_irq() call and for the preceding clients[] access leaving
> it unprotected against concurrent client (un-)registration.
> 
> Furthermore the accesses to ism->sba_client_arr[] in ism_register_dmb()
> and ism_unregister_dmb() are not protected by any lock. This is
> especially problematic as the client ID from the ism->sba_client_arr[]
> is not checked against NO_CLIENT and neither is the client pointer
> checked.
> 
> Instead of expanding the use of the clients_lock further add a separate
> array in struct ism_dev which references clients subscribed to the
> device's events and IRQs. This array is protected by ism->lock which is
> already taken in ism_handle_irq() and can be taken outside the IRQ
> handler when adding/removing subscribers or the accessing
> ism->sba_client_arr[]. This also means that the clients_lock is no
> longer taken in IRQ context.
> 
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

...

> @@ -71,6 +80,7 @@ int ism_register_client(struct ism_client *client)
>  		list_for_each_entry(ism, &ism_dev_list.list, list) {
>  			ism->priv[i] = NULL;
>  			client->add(ism);
> +			ism_setup_forwarding(client, ism);
>  		}
>  	}
>  	mutex_unlock(&ism_dev_list.mutex);

...

> @@ -92,6 +102,9 @@ int ism_unregister_client(struct ism_client *client)
>  		max_client--;
>  	spin_unlock_irqrestore(&clients_lock, flags);
>  	list_for_each_entry(ism, &ism_dev_list.list, list) {
> +		spin_lock_irqsave(&ism->lock, flags);

Hi Niklas,

The lock is taken here.

> +		/* Stop forwarding IRQs and events */
> +		ism->subs[client->id] = NULL;
>  		for (int i = 0; i < ISM_NR_DMBS; ++i) {
>  			if (ism->sba_client_arr[i] == client->id) {
>  				pr_err("%s: attempt to unregister client '%s'"
> @@ -101,6 +114,7 @@ int ism_unregister_client(struct ism_client *client)
>  				goto out;

But it does not appear to be released
(by the call to spin_unlock_irqrestore() below)
if goto out is called here.

>  			}
>  		}
> +		spin_unlock_irqrestore(&ism->lock, flags);
>  	}
>  out:
>  	mutex_unlock(&ism_dev_list.mutex);
