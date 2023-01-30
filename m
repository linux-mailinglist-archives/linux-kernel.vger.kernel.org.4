Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAB681A99
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbjA3Tfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjA3Tfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:35:51 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7B402C1;
        Mon, 30 Jan 2023 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675107336; bh=+x4U1ZGoO6PY6ygplAfz+5R9wtZLDJBNLZGOD1KKU/0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=dWRBRZNXXlZqHR/qLhNy8A5yK5atfj1KL8NH/E6OKXqKwnMi1Umz78BMc8n7uhaze
         4Lm3KFVd49LuTJ8y/DLZgk8H2eh8H/VHCmmEfgaG12KSrZCSYZkZj4q26caunKNG3z
         K4k/brYIPuWu2OGxvJsyha/aPVJwoQaqZBSOM77U=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 30 Jan 2023 20:35:36 +0100 (CET)
X-EA-Auth: /NVXSvT9TTEUYaQzpm9xBGzKBT5tQZmMocGHGydt1b0+IxF5L2UjMcJPR3VYisyy34/99q4B3gJQdsq8EfCMloh95of2TLeD
Date:   Tue, 31 Jan 2023 01:05:33 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] scsi: snic: Use sysfs_emit in show function callback
Message-ID: <Y9gcBe/Qmp6Vuz/3@ubun2204.myguest.virtualbox.org>
References: <Y9fvsSJrflcIHm7e@ubun2204.myguest.virtualbox.org>
 <4bd7788a-bf6f-40c7-4439-2a300045c5e3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd7788a-bf6f-40c7-4439-2a300045c5e3@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:51:40AM +0530, ALOK TIWARI wrote:
> code changes look good.
> 
> commit message can be more simpler like  "show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space."
> 
> and in place of kobject attributes , device attribute is more relevant here.

Hi Alok,
Thank you for the feedback. Your commends make perfect sense. Shall I resend a
v2 with the simplified language?

Regards,
Deepak.

> 
> Thanks,
> Alok
> 
> On 1/30/2023 9:56 PM, Deepak R Varma wrote:
> > According to Documentation/filesystems/sysfs.rst, the show() callback
> > function of kobject attributes should strictly use sysfs_emit() instead
> > of sprintf() family functions.
> > Issue identified using the device_attr_show.cocci Coccinelle script.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >   drivers/scsi/snic/snic_attrs.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/scsi/snic/snic_attrs.c b/drivers/scsi/snic/snic_attrs.c
> > index 3ddbdbc3ded1..56c46ea06e60 100644
> > --- a/drivers/scsi/snic/snic_attrs.c
> > +++ b/drivers/scsi/snic/snic_attrs.c
> > @@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
> >   {
> >   	struct snic *snic = shost_priv(class_to_shost(dev));
> > -	return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
> > +	return sysfs_emit(buf, "%s\n", snic->name);
> >   }
> >   static ssize_t
> > @@ -23,8 +23,7 @@ snic_show_state(struct device *dev,
> >   {
> >   	struct snic *snic = shost_priv(class_to_shost(dev));
> > -	return snprintf(buf, PAGE_SIZE, "%s\n",
> > -			snic_state_str[snic_get_state(snic)]);
> > +	return sysfs_emit(buf, "%s\n", snic_state_str[snic_get_state(snic)]);
> >   }
> >   static ssize_t
> > @@ -32,7 +31,7 @@ snic_show_drv_version(struct device *dev,
> >   		      struct device_attribute *attr,
> >   		      char *buf)
> >   {
> > -	return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
> > +	return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
> >   }
> >   static ssize_t
> > @@ -45,8 +44,7 @@ snic_show_link_state(struct device *dev,
> >   	if (snic->config.xpt_type == SNIC_DAS)
> >   		snic->link_status = svnic_dev_link_status(snic->vdev);
> > -	return snprintf(buf, PAGE_SIZE, "%s\n",
> > -			(snic->link_status) ? "Link Up" : "Link Down");
> > +	return sysfs_emit(buf, "%s\n", (snic->link_status) ? "Link Up" : "Link Down");
> >   }
> >   static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name, NULL);


