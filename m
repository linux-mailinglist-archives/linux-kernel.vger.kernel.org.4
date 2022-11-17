Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6962D076
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiKQBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiKQBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:12:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC3E3E0A0;
        Wed, 16 Nov 2022 17:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668647538; x=1700183538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CAW6Z7j1RBqevBDwlp/z7wofWV01Bb5+tRXsSHwGszM=;
  b=R7Stftrz0WQ6DI8wMXJbehSd9EWlGShfmn83Dmw7SR3jZU0CgSSHShwM
   Q9Ragiu1USfCppAhRm+iiBNFAeo5eb/Cm1TyX80NjHc1m3bc3BURB9Gee
   npT61G7YJsz4O8xroshz0r8FCVg7LU5c7yaZqcUwtDPjrBGUEEO9XK+iL
   uJmwDGK2ny6KcGrBYrWJBOIhOf3DJllh+fvpY6PyvngbhwLkkEKU3RTTO
   h4zgJKz4lksjBXKkld5Be+6hsjR3yA+mR5IRJBxLb9U4OVCaI4SjvnHFM
   RfM37eCzxMtqrtdsIQiT9pJpMtnIHF1ZA+bfHR215rU2qq9pConOxIA+c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="339538814"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="339538814"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="703111070"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="703111070"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2022 17:12:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:12:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:12:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:12:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:12:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn3onSDboFL8Kp16KYy5Nq3aJP4sDTsclSfq+L4HdZTuovo9HO6GKGDHKjuvh6JcHENxU5Uv5+c7fEjjcuoH4Q/V9mzGY2AtrH9LY4uKGTewN18n6itqRU8Dr0XLpRDeYQTTQPK8/ODygfSxIxetpKgCxlzljl2ooPsU5PkVX3lUmiTtdXikpW2qzlx/ofRF9HH4zx6BiS/k4EzHRB+MOTXw96Va4iv8zPQiVwzRPa2d1DNr6saB/Wz+FlUps/0VoAqfFrjZyzWJu5JooFpj0pDqvokcCNXLZ66MPByGdxQ31NgfAcsRvc8rFDaU40TxLbm6NfXPc3Q6GVW+bPq0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9uRHycO3NBdVP0KXDOYq43z0c+FAa3v6oJmYxaniyA=;
 b=mJJ9BqcrzhCXZIqKXtgPvnsIZ0a3NQo/cOSv+kBh/Ek7bZ8P6jqflMVI0QoMZNB8taqnBoIRsnX60Auj+YgDhn4lwZXzo63by4PMM9mJUlVWxbJBz831O2Pt9W5rh4IR9FgniklgaXWmcp/RhK0pgnGBAQ9w+mmTMNsit8tb+nzRttYF944VJBoxGpcm7x1rKaWn9mAoyNbUHry6Q/we4iNbdMDjso2T+h2JjmR8S7wLok//fHwHPsNwaugcExnWbDD3kQ+zLMDA7n1vrISLMcbl263JRCbrI+KXbr5HZhnhzQhY+4ojPwVQhyn3YKcem5BBi1DCGA6O2ageBs1rMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:12:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:12:15 +0000
Date:   Wed, 16 Nov 2022 17:12:11 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <Y3WKaxd4cGmdOMz4@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-4-ira.weiny@intel.com>
 <20221116152426.0000626b@Huawei.com>
 <20221116154543.00003c6a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116154543.00003c6a@Huawei.com>
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c52671e-c459-4838-ce82-08dac838c372
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3oGtcr5JM7iWjePIqO2xyXSwGUsbN5Cab2tHp6I0ioww2RX4tJKY8EXftg1aEGxPyltjUttSnr+oApC2ZUi6R9VPTtz6fyd7THF0akWGVdvtc/oZAh/2Zh0+QJLKhZMsZp8JJkQwbPTtb/MkOsDPdRvb0n2rM9omh+iQX18Jcevb544NGgIOIut+Djhfr08/JslHIcfM6aInLrnLhYyrRnjJ0qfLJ2R6VnaZShH51dPg0Z2aWKhndzMpwv/WwBFFPPiAWS5Ne6JnYvrjbfzln69rjjL9l+4X3bkM5xxHkILkHEkbEGaAbPxVDLPvv3Z7e6FdLjHSp1nPOS/W8ooAszQeb8BaCuW2xw2G77zRZX+RWtBKVvuPaP+WUbqglsAqJbBWwqk2YE5CHm/5Cc97/5Xc/jvPvU6I2P7jJp9Rmooz4qiI9vKLytDZHtoHvwAgUKYRdHRlJqa6BFfV0H+j8OkPI8EUJq9GN3mKYx95bOF4Sg/YDu11/JsprL8u/plHddRfMpmDrmuot2MS06ST80M6R7KY+R2XbY8G5m4Z4k+rVU/aou3jr3RKupqDz0mspHsG1Md8gpcVPZCqkzTphKL8v3BzLxElFmzJ8tBGJvfFmd1vkc+J7beA+zNXlu3j610a9RrbRJenaJ2HUtbv6hYnzqPG/0GF31VR942L0397q7VZcH4qV8CFUoTHOU3L9/EGa/95HJIFqnSQ/yKjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(83380400001)(86362001)(26005)(6512007)(9686003)(186003)(6666004)(33716001)(82960400001)(478600001)(6506007)(38100700002)(8936002)(41300700001)(44832011)(2906002)(5660300002)(6916009)(54906003)(6486002)(66946007)(8676002)(66556008)(316002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmeO5ny3JPwlXcy7tfNaLgxHqILFPUA/RGl8EWvw2O220UYB8idSoaEJ/ziR?=
 =?us-ascii?Q?ske5z0IXSkhC5x50B8OmYz3Rt4re5XVTKJYeI3N6DO4FpXMFIqOZF2IYh47O?=
 =?us-ascii?Q?BhFSa6XwD/K4qpejusQgGFqGdZBTt1BijuhUM5u5hEMudpx6/QPHQhUvAvmx?=
 =?us-ascii?Q?J2YhFZf0Ve4bdz4/Oupv4eiut/Qc9UXH+CT4sl6j5Xpqqyi0lP81v0aUK3fX?=
 =?us-ascii?Q?v3Ppa+jTM9F+8xfoGgWLASfhKzmLAY7r2fwnoctYna4ZcmfGi/WpeKY5tSfV?=
 =?us-ascii?Q?G9OJ6SJT2QKa72MdDFXDmHpDh1nOa3XkVdLoOhPNV1bnDo5gVaYmV53qZyv6?=
 =?us-ascii?Q?2DYw4JJ/b6grcLmAgXE3UpQPv1Xe2EEgbhaZf6gGCniLiZbhEVDD3BDsuLZZ?=
 =?us-ascii?Q?rrzagKjRa+02Zf6XUHKq3s6wElBxBEWapTrOnRcgf94AqjppwULm7uDlYESq?=
 =?us-ascii?Q?ps908hF1H+gq19ZTD25Uelmvlb78V6BaA0nGeen8ickXOajsN+lVxL42M6ad?=
 =?us-ascii?Q?6n3x1XC0U6hY1IR8VAS6Uu3TPpMsijZ/ACIspZb5vLpHEA/Q0XU7M877Ayd1?=
 =?us-ascii?Q?JsuOmpADnkDy+Vb9XwKm+i9DxeUkqYPjxr7RKTcYzlb7vvbpe6hNOk5K2HsT?=
 =?us-ascii?Q?DussivFQ624dvXOKbR6OxrcTY9ipF6vglj3uVpeHDkMrjjaaLxujeDkTmsTg?=
 =?us-ascii?Q?SFeizTEh87KOfIgCsql+CbYPIl5neBHK60cabtC61V49MTOOBq40wi7pJWFx?=
 =?us-ascii?Q?XlKl0RP5kp3OfH6+gbKobBadQC6iyXDe6h/JX/QB9x/GPWxrO/YlAS7D2NGE?=
 =?us-ascii?Q?qxJoFONQ75gKMTK8G5WBUG1NoMjDSnCMkGBF1z71LO02AjCEjBIXCs7WbUg4?=
 =?us-ascii?Q?AgqdCIsBaquWBbhvK1J/Dk/gWEz3nZ33jdneMX4men3rnSWLc+C6yODsaDLa?=
 =?us-ascii?Q?WT4B4BTElvT3BE7SN8T+xhtQtof3T4Z+qFwqgGGizM22x29CZgTEqTxWtEZ/?=
 =?us-ascii?Q?9JItf6xEu0nyvCKZ49+CfHZJV7JxsWgby2ZIgiAqGxhJExvoq3UYo8VSB/CV?=
 =?us-ascii?Q?S/BbpFUEMTZ9esNmy2MXJA8/GXQqRLO1iR4DdI42Q0Hp4XbX6u/csIEBppdC?=
 =?us-ascii?Q?waaJv9rYUQoYQj8W5WaWyGoIMpxTj4c41mpLVEWq5xBlUs66lTH3HK/+Mq37?=
 =?us-ascii?Q?F4vWza2uyA3agKQHB1YCxLBnWQSqe8DqBuqPDOmHc29mW1Yd+2w1dSuEHki/?=
 =?us-ascii?Q?eYmHf52FrPBkDlTUvBxov8Gb0BEjBf7lCHNe8H/L9dMbvwjNGVZhOcoPEDsI?=
 =?us-ascii?Q?WfygJD8Fz/yF6Kj0e7RYKsuYKrWmWuscYhf8yEY9VTIHMbv6ijhRh2oCTcCA?=
 =?us-ascii?Q?SmgocmwQiLob42PVyULSa6IutW9Z6M6jQGcr4ftKa2gida8pbGj0dJPZv3vP?=
 =?us-ascii?Q?+JmNvnLsiz8Zpgm/MRVGZhLyvA/xdRj7iz+8BdZX5qHpujgQxkZReV06WC9S?=
 =?us-ascii?Q?4fXR8l/CbbHj4pVwPonPCnOznjJVzJyJKcjjn6+E+RxsCETs/pAB2FOICA5a?=
 =?us-ascii?Q?M+/zr7eaLG1ZflXX28dNBob1Lh+5boEwRzmjPZ/w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c52671e-c459-4838-ce82-08dac838c372
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:12:15.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLLdqx9gQbC1y3xS7VcsRCKMRAcvhPKRKGJ+fGeCXkrXrF88PS2o0+T9YQbzNDIkVQP61853R7ocxdx4KEV8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:45:43PM +0000, Jonathan Cameron wrote:
> On Wed, 16 Nov 2022 15:24:26 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 

[snip]

> > 
> > 
> > > + */
> > > +struct cxl_mbox_clear_event_payload {
> > > +	u8 event_log;		/* enum cxl_event_log_type */
> > > +	u8 clear_flags;
> > > +	u8 nr_recs;		/* 1 for this struct */  
> > Nope :)  Delete the comments so they can't be wrong if this changes in future!
> Ah. You only use one. So should hard code that in the array size below.

No it can can send up to CXL_GET_EVENT_NR_RECORDS at a time : 'nr_rec'.


                        rc = cxl_clear_event_record(cxlds, type, &payload, nr_rec);


static int cxl_clear_event_record(struct cxl_dev_state *cxlds,                                                                  
                                  enum cxl_event_log_type log,                                                                  
                                  struct cxl_get_event_payload *get_pl, u16 nr)                                                 
{                                                                                                                               
        struct cxl_mbox_clear_event_payload payload = {                                                                         
                .event_log = log,                                                                                               
                .nr_recs = nr,                                                                                                  
                ^^^^^^^^^^^^^^
                Here...

        };                                                                                                                      
        int i;                                                                                                                  
                                                                                                                                
        for (i = 0; i < nr; i++) {                                                                                              
                payload.handle[i] = get_pl->record[i].hdr.handle;                                                               
                dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",                                                           
                        cxl_event_log_type_str(log),                                                                            
                        le16_to_cpu(payload.handle[i]));                                                                        
        }                                                                                                                       
...

Ira
