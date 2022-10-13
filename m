Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2F5FD428
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJMFQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJMFQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:16:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3A129086;
        Wed, 12 Oct 2022 22:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clTkJSl+79+lkDhe0WSqS3bmIG2dTcxGkKTTgKqmOHKUKczHawO2ckncV10T2ttubEvG0k1BEpRYpLvblIMoxlYICT/2ooVysWuripBx7qcQjlKXtI/pXpCFuZiynumaCXduk6QctwhgdVP7BRUZ2mr3HDye60zCN50IrdefLN+Omsx3+1lNQR1NFmc6uoV17knTfg8jmZMaZnQ/DK6bpT95YtST2HRHOMcxakOjVHByv24mHwGWQ33UjjWTcwRbfKkui0UxwIFK1wfoFMFueQ3/Y7RdquNFwX1QTcFaypy54JHdgXpt/5gZI9U2yNz4g2rhXNfbenO+V82BIGUeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY7nI+QMNraDT3O5d6qhR58VBCs/tbPWLvxPHkBxHw4=;
 b=aYfmh5JIe3n1eycyB+EKiLNgT2ZlZVvUU0NpMAM7a7h9OnLGBM283aCI00HfE0HWX26uzIceNnRpDe0qPBzYqKArFpQKNyTyAMuf/xxox0ZgK3gRnp8StUOGX85znSc+NxNZxPSgY6KqYvkoAxPRdMEbCM08WbQ/tM/MOOekBDFG7PQuvXBPoNYq05/NQNyS1JOdqSy9/Cp+pGa2hmcSuoDc/3YrVykXbj2j4JoxavZPY2BOLO6/pNWU4aKwpN36BX8tT8s1lsop5mCViNcFnq+9TFCpjNngqG47lj87wB0MHMDw/FoF1H5viA6Gba8ObVf5E/AybWtrdJrrltQYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY7nI+QMNraDT3O5d6qhR58VBCs/tbPWLvxPHkBxHw4=;
 b=cD5iDtvJPTH6XdbB2XRzSOmRfutckBUM9oIz55C0OaMsark2mJVtiAeV95jbsk0556n7bxz/CQbQ66e1k5mznDHo6hsWqJWRD2KNkPT9dcl/aq8ro4OPXy2XGhqPwsdrTeesenFwvaPsG2ockm/b9obIs1Dk4R02JElSz+5l7SJs1jNbHZcP74FLfywkNk+x/QmqA2jA8hbA/Rbn47R+Lg+7JvVInwZ+XVP8exfA4AtvOLynZ+N5p1M1tYC2FHIvxhj5bDB1kNATkXJ+9d/XrRdvRf/ZHNxNTfwk+PKAIlIHdGUhr4KfH8c6vlY/xzBuMguLf//n3y7MXo6CNW4Qlg==
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 05:16:41 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::90) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 13 Oct 2022 05:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 05:16:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 12 Oct
 2022 22:16:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 12 Oct 2022 22:16:30 -0700
Received: from thinkpad-t480.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 12 Oct 2022 22:16:28 -0700
From:   Johnny Liu <johnliu@nvidia.com>
To:     <cwchoi00@gmail.com>
CC:     <cw00.choi@samsung.com>, <johnliu@nvidia.com>,
        <kyungmin.park@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2] devfreq: Support device update function
Date:   Thu, 13 Oct 2022 13:16:27 +0800
Message-ID: <20221013051627.17171-1-johnliu@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <24e701e9-b560-5350-a2f7-89e2a4a1c97a@gmail.com>
References: <24e701e9-b560-5350-a2f7-89e2a4a1c97a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8e3882-d6b2-4b1d-69b7-08daacda1ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wHnwPR1CueVBbBs0t3Gq/te6ZP8cBNb9HpzGFbE3J/zCD+mr/rSmY4hjujatWAaV2NLrCLBhev92lWIjEpnaCHNNZ8YuBQ83UeiCKN1Yg92a/xZBZ4Jb3Pk8W8TTHKQ1DmA8GKy/qduWoPVj+SdP1A04KHVjbPNA0iAOFNyKzLBTNTKqHinxc4siepiCSyxifgecUsFcYCwgqF7I63EpdRYQ5e9BMyM4fq8DX5RRx9nd5/IzSOVc/Fea4iZnAOQYFxN1p2F6/dFZBfeSoAQ/dLvF6vd2rZz5MsLqELRVdCbl9aNtehu75rX5k9YId3gbpB6t00Rxn4j0NG27C5z8e4D9FWL+o4J4EQOU1SUd4WzGqj6SA1tUFzy+0Kp10L0Le/BIIn+L6/IriP1gYEieDjVzXoj4erpIodTWQTAE6E/VWgRlT2YjHHSrHXF7OP2tWzpMkDNaY/YrhFKPhpEXY0+YCrCH9xLpqEmkVtY6gFQ+jFYkSwzt4Vmd8+Fx2ofoU0gC/MYVO36ZczDePL58iD7PtokPSBDue1+uL9scQxeXcsM9LxQGWnvVTaV7+P3/lZphrfj1RCm+5iGLVZOel2qwGx2rwVWz9VORLs46JnV058AxFAaBv0+RV/iBlMtsvNYceQd3ABQyT3JFMW1FPHm34eYNcniTlgHUMH3N/TFMXqAw2+qvW+NKX8w1bCV7P5qXxB5Uy1zpiadcn/DSa7o07DzZYS8+WnNCiBSmd93DbFwrMSAvybxZOcK1Z07c9zLTB1G6+QNf7UXCDYo9A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(7696005)(36756003)(26005)(40460700003)(5660300002)(82310400005)(15650500001)(316002)(6916009)(2906002)(8676002)(40480700001)(186003)(478600001)(8936002)(41300700001)(54906003)(356005)(4326008)(70206006)(70586007)(1076003)(7636003)(36860700001)(82740400003)(426003)(86362001)(83380400001)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 05:16:41.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8e3882-d6b2-4b1d-69b7-08daacda1ce7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick response and detailed comments. I will prepare a new patch
series to include the user of the proposed function. But still I answer your
concerns in the following sections.

On Thu, 13 Oct 2022 04:44, Chanwoo Choi wrote:
> Hi,
>
> Basically, struct devfreq_dev_profile is used to pass the devfreq device data
> from devfreq driver to governor. But, This means that it passes
> the data from governor to devfreq driver reversely?

Yes, it means that governor can pass data to devfreq driver reversely.

> On 22. 10. 3. 15:02, Johnny Liu wrote:
> > To realize interrupt-driven closed-loop governors, governors need to be
>
> Could you explain the detailed means of 'interrupt-driven closed-loop governors'?

For term "interrupt-driven", it means the DFS logic is triggered by interrupts
rather than performing DFS in a polling fashion. This can reduce the CPU load.

For term "closed-loop", it means that there is a target metric the governor will
try to keep it at certain value/level. For example, if the target metric means
device utilization, then the governor should perform DFS so that it will keep
device utilization at certain level specified by the user.

> > able to send data to the underlying devfreq driver to ask for updating
> > the device settings, such as hardware registers for frequency limits,
>
> I think that governor is not able to get the hardware information direclty
> instead of devfreq driver. Usually, the devfreq driver should get the
> h/w info and then passed to governor if required.

Yes, governor should not be able to the HW info directly. From my perspective,
I think governor should be able to pass down hint, such as device utilization
specified by the user in the governor, to the devfreq driver. Then, the
devfreq driver can configure the device accordingly so that interrupts get
triggered when device utilization exceeds or drops by certain amount.

> Lastly, this patch doesn't contain the any use-case of devfreq_update_dev().
> I prefer to post the real use-case of this patch.

I will include the user of it in a new patch series.

> > which are compared against the device frequency to generate interrupts
> >
> > Since governors might export several tunable parameters, users can
> > enforce different policies for the control logics. Under different
> > policies, governors need to send different information to inform the
> > devfreq driver to configure the device accordingly.
> >
> > The introduced update function improves the flexibility of governors
> > and acts as a communication interface between governors and devfreq
> > drivers.
> >
> > Signed-off-by: Johnny Liu <johnliu@nvidia.com>
> > ---
> > v2: Correct the function signature of devfreq_update_dev
> >
> >  drivers/devfreq/governor.h | 8 ++++++++
> >  include/linux/devfreq.h    | 8 ++++++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> > index 0adfebc0467a..b5781fa549c7 100644
> > --- a/drivers/devfreq/governor.h
> > +++ b/drivers/devfreq/governor.h
> > @@ -124,4 +124,12 @@ static inline int devfreq_update_stats(struct devfreq *df)
> >
> >  	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
> >  }
> > +
> > +static inline int devfreq_update_dev(struct devfreq *df, void *data)
> > +{
> > +	if (!df->profile->update)
> > +		return -EINVAL;
> > +
> > +	return df->profile->update(df->dev.parent, data);
> > +}
> >  #endif /* _GOVERNOR_H */
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index 34aab4dd336c..91648e8f8d76 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -92,6 +92,8 @@ struct devfreq_dev_status {
> >   *			devfreq.last_status.
> >   * @get_cur_freq:	The device should provide the current frequency
> >   *			at which it is operating.
> > + * @update:		An optional function to allow governors send data back
> > + *			to the devfreq driver to update the device settings.
>
> IMO, 'update' word is too generic. I think that 'update_device_data' is better
> to improve the readability.

Yes, "update_device_data" has better readability compared to "update".

> >   * @exit:		An optional callback that is called when devfreq
> >   *			is removing the devfreq object due to error or
> >   *			from devfreq_remove_device() call. If the user
> > @@ -114,6 +116,7 @@ struct devfreq_dev_profile {
> >  	int (*get_dev_status)(struct device *dev,
> >  			      struct devfreq_dev_status *stat);
> >  	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
> > +	int (*update)(struct device *dev, void *data);
> >  	void (*exit)(struct device *dev);
> >
> >  	unsigned long *freq_table> @@ -451,6 +454,11 @@ static inline int devfreq_update_stats(struct devfreq *df)
> >  {
> >  	return -EINVAL;
> >  }
> > +
> > +static inline int devfreq_update_dev(struct devfreq *df, void *data)
> > +{
> > +	return -EINVAL;
> > +}
> >  #endif /* CONFIG_PM_DEVFREQ */
> >
> >  #endif /* __LINUX_DEVFREQ_H__ */

--
Best Regards,
Johnny Liu
