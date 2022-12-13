Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AC64BEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiLMVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiLMVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:08 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB71264B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:53:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w26so3155218pfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Op9epK10mV5MOVPxBoVD7ue6DyUW9jmXXw0ypVsmadA=;
        b=AaP/LojTErSv5xNFufsGIIVXHKM6UL8lJpmUFhlgI0qozxGwT+XvDRduLqYMB9z9L7
         GiE0EaiJOxqEsCTOCWdByvNW8u0VptNsWspbp/dezxLFodU5BVW3oULiI+4PfWPNrOn2
         j6bfzCSeC8lQJKq5bKshVGKkBnNjJ90Ojt6Cy7CsDgyPB1DZ+nJg3IsQSSXiq0QNA0Ty
         2j9LnDW88eFwabsMHGlBVDBKXJMsy35EWI0yreYI8QQUj2RFZjhpypSXqJXDLYYjUkRD
         LVRtLbLzbPr45kzIMH9/tLg2heVh44Jh7SXJEAmPGdIQIc2DXfvsaqgDFk3yj6eDyNe9
         13gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op9epK10mV5MOVPxBoVD7ue6DyUW9jmXXw0ypVsmadA=;
        b=kC7bDzMffkHKhyrfAdqL5GUc1XKXmpeWWV2T3OAUXhfxV24Se7FzecnWx/IWAU2dPw
         c/bHs+5wknZe+WOs3XMYRkTsz2lEaz+0lEIZTwAkaNUY0cwforNNoudC2P0v+aiY3RCt
         C9J0Gs/8aTrrWvg8mYvMJJrBR0BVxg4Pa6S6xgFXWv0EJBjpkl67yRkSwyY6Jifn3K7Q
         2RwNvsFTDP3ZZL5ndX9dmNDwpyIE8p/6a3Rg2OikjRU8E8CGodcvy1slm4hnKy0hOYqC
         VUEoepVJKy+miYKQvo5EvU5pgfdMLJ7s7sTcy8p2rR0PQE/YfNKn/hI55WtosypuL2Xk
         QWcA==
X-Gm-Message-State: ANoB5pmpiq2BN1BzFS4Q35Jx6HMttCjiX1OMNKVhikxD3rIpZnw5LCwl
        ZNueI+jfY3k7XAX6rYM/7vrQ0A==
X-Google-Smtp-Source: AA0mqf4kxyBlbfTYZPYW19whcUQAWpCeHVgvNR0zbDhRrA19EtLBythaT1kxyS3cadLn8cl0kEYMVg==
X-Received: by 2002:a05:6a00:1c89:b0:576:e33e:cd63 with SMTP id y9-20020a056a001c8900b00576e33ecd63mr20125063pfw.30.1670968402363;
        Tue, 13 Dec 2022 13:53:22 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:54b2:2a34:2ab1:fb83])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm8139556pfr.28.2022.12.13.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:53:20 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:53:18 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Ben Levinsky <blevinsk@amd.com>
Cc:     "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "bill.mills@linaro.com" <bill.mills@linaro.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] remoteproc: Introduce rproc_get_by_id API
Message-ID: <20221213215318.GA893317@p14s>
References: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
 <20221115153753.2065803-2-ben.levinsky@xilinx.com>
 <20221125180509.GA622847@p14s>
 <C981698C-5B9B-49B6-9EC2-CC7A0737B155@amd.com>
 <20221202170042.GA165812@p14s>
 <ba21b0e5-80e2-d976-1bf3-98a91825086b@amd.com>
 <20221208190523.GA636328@p14s>
 <b49ad56a-f008-55e3-22a7-c47afe5bdd3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49ad56a-f008-55e3-22a7-c47afe5bdd3e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:01:47AM -0800, Ben Levinsky wrote:
> Hi Mathieu,
> 
> On 12/8/22 11:05 AM, Mathieu Poirier wrote:
> > On Tue, Dec 06, 2022 at 08:23:13AM -0800, Ben Levinsky wrote:
> > > Good Morning Mathieu,
> > > 
> > > 
> > > I did some testing and replied inline.
> > > 
> > > 
> > > On 12/2/22 9:00 AM, Mathieu Poirier wrote:
> > > > On Wed, Nov 30, 2022 at 09:39:33PM +0000, Levinsky, Ben wrote:
> > > > > Hi Mathieu,
> > > > > 
> > > > > Thank you for your review. Please see my reply inline.
> > > > > 
> > > > > Thanks
> > > > > Ben
> > > > > 
> > > > > On 11/25/22, 10:05 AM, "Mathieu Poirier"<mathieu.poirier@linaro.org>  wrote:
> > > > > 
> > > > >       CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> > > > > 
> > > > > 
> > > > >       Hi Ben,
> > > > > 
> > > > >       On Tue, Nov 15, 2022 at 07:37:53AM -0800, Ben Levinsky wrote:
> > > > >       > Allow users of remoteproc the ability to get a handle to an rproc by
> > > > >       > passing in node that has parent rproc device and an ID that matches
> > > > >       > an expected rproc struct's index field.
> > > > >       >
> > > > >       > This enables to get rproc structure for remoteproc drivers that manage
> > > > >       > more than 1 remote processor (e.g. TI and Xilinx R5 drivers).
> > > > >       >
> > > > >       > Signed-off-by: Ben Levinsky<ben.levinsky@xilinx.com>
> > > > >       > ---
> > > > >       >  drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++-
> > > > >       >  include/linux/remoteproc.h           |  1 +
> > > > >       >  2 files changed, 64 insertions(+), 1 deletion(-)
> > > > >       >
> > > > >       > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > >       > index 775df165eb45..6f7058bcc80c 100644
> > > > >       > --- a/drivers/remoteproc/remoteproc_core.c
> > > > >       > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > >       > @@ -40,6 +40,7 @@
> > > > >       >  #include <linux/virtio_ring.h>
> > > > >       >  #include <asm/byteorder.h>
> > > > >       >  #include <linux/platform_device.h>
> > > > >       > +#include <linux/of_platform.h>
> > > > >       >
> > > > >       >  #include "remoteproc_internal.h"
> > > > >       >
> > > > >       > @@ -2203,13 +2204,74 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> > > > >       >
> > > > >       >       return rproc;
> > > > >       >  }
> > > > >       > +
> > > > >       > +/**
> > > > >       > + * rproc_get_by_id() - find a remote processor by ID
> > > > >       > + * @phandle: phandle to the rproc
> > > > >       > + * @id: Index into rproc list that uniquely identifies the rproc struct
> > > > >       > + *
> > > > >       > + * Finds an rproc handle using the remote processor's index, and then
> > > > >       > + * return a handle to the rproc. Before returning, ensure that the
> > > > >       > + * parent node's driver is still loaded.
> > > > >       > + *
> > > > >       > + * This function increments the remote processor's refcount, so always
> > > > >       > + * use rproc_put() to decrement it back once rproc isn't needed anymore.
> > > > >       > + *
> > > > >       > + * Return: rproc handle on success, and NULL on failure
> > > > >       > + */
> > > > >       > +
> > > > >       > +struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
> > > > >       > +{
> > > > >       > +     struct rproc *rproc = NULL, *r;
> > > > >       > +     struct platform_device *parent_pdev;
> > > > >       > +     struct device_node *np;
> > > > >       > +
> > > > >       > +     np = of_find_node_by_phandle(phandle);
> > > > >       > +     if (!np)
> > > > >       > +             return NULL;
> > > > >       > +
> > > > >       > +     parent_pdev = of_find_device_by_node(np->parent);
> > > > >       > +     if (!parent_pdev) {
> > > > >       > +             dev_err(&parent_pdev->dev,
> > > > >       > +                     "no platform device for node %pOF\n", np);
> > > > >       > +             of_node_put(np);
> > > > >       > +             return NULL;
> > > > >       > +     }
> > > > >       > +
> > > > >       > +     /* prevent underlying implementation from being removed */
> > > > >       > +     if (!try_module_get(parent_pdev->dev.driver->owner)) {
> > > > >       > +             dev_err(&parent_pdev->dev, "can't get owner\n");
> > > > >       > +             of_node_put(np);
> > > > >       > +             return NULL;
> > > > >       > +     }
> > > > >       > +
> > > > >       > +     rcu_read_lock();
> > > > >       > +     list_for_each_entry_rcu(r, &rproc_list, node) {
> > > > >       > +             if (r->index == id) {
> > > > >       > +                     rproc = r;
> > > > >       > +                     get_device(&rproc->dev);
> > > > >       > +                     break;
> > > > >       > +             }
> > > > >       > +     }
> > > > > 
> > > > >       This won't work because several remote processors can be on the list.  If
> > > > >       another remote processor was discovered before the one @phandle is associated
> > > > >       with, the remote processor pertaining to that previous one will returned.
> > > > > 
> > > > > I didn't understand. From my point of view passing in the phandle of the child-platform device here will work because each child-platform will have its own entry in the remoteproc list.
> > > > You are correct, each child platform device will have its own entry in
> > > > @rproc_list.  The problem is that r->index may not match @id that is passed as a
> > > > parameter.
> > > > 
> > > > > Also " If    another remote processor was discovered before the one" Here this prevented from what I can see because the remoteproc_list is protected by a mutex_lock. Seehttps://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2288  for the mutex_lock.
> > > > > 
> > > > > Additionally the calls to zynqmp_r5_add_rproc_core() are called sequentially so this also prevents the race condition.
> > > > > 
> > > > > I think I am missing something in your paragraph above. Can you expand on this issue?
> > > > As explained above, the issue is not about race conditions but the value of
> > > > r->index and @id.
> > > > 
> > > > >    Do you mean to say that if we use the cluster platform device you think using one of the existing APIs will work? For example rproc_get_by_child() or rproc_get_by_phandle()
> > > > > 
> > > > > Athttps://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923  " zynqmp_r5_add_rproc_core(&child_pdev->dev);" Here if we use cluster->dev this will work? To dig deeper into this for both the Xilinx and TI R5 remoteproc drivers, I think this proposed solution will create an issue in that for Split modes, the existing getter APIs will not be able to return one of the corresponding rproc instances because both cores will refer to the same platform-device structure.
> > > > > 
> > > > > I can bring up the above in the community call.
> > > > > 
> > > > >       There is also an issue with rproc_put().
> > > > > 
> > > > > If passing the cluster platform device works for the above then rproc_put() should work correct? We can test this on our side as well. That being said I can bring this up in the community call
> > > > Yes, using the cluster platform device will work with rproc_put().
> > > > 
> > > > > 
> > > > >       I think your description of the problem is mostly correct.  The intermediate
> > > > >       devices created by the cascading entries for individual remote processors in the
> > > > >       device tree are causing an issue.  The "compatible" string for each remote
> > > > >       processor can't be handled by any platform drivers (as it should be), which
> > > > >       makes try_module_get() fail because r->dev.parent->driver is not bound to
> > > > >       anything.
> > > > > 
> > > > >       Looking at the code for Xilinx's R5F support that I just queued[1], the simplest
> > > > >       solution may be to pass @dev, which is in fact @cluster->dev, to
> > > > >       zynqmp_r5_add_rproc_core() rather than the device associated with the
> > > > >       intermediate platform device.
> > > > > 
> > > > >       That _should_ work.  It is hard for me to know for sure since I don't have a
> > > > >       platform that has dual core remote processor to test with.
> > > > > 
> > > > >       Get back to me with how that turned out and we'll go from there.
> > > > > 
> > > > >       Thanks,
> > > > >       Mathieu
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > >       [1].https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923
> > > 
> > > I have an update on this.
> > > 
> > > 
> > > 
> > > I tested the following using the RPU-cluster platform device:
> > > 
> > > test 1: RPU split with 2 core
> > > 
> > > test 2: RPU split with 1 core
> > > 
> > > test 3: lockstep RPU
> > > 
> > > 
> > > I tested with the zynqmp-r5-remoteproc platform probe using the (RPU)
> > > cluster platform device instead of the core/child platform device. When I
> > > used this I was unable to properly use the API rproc_get_by_phandle() and
> > > there was _only_ an issue for test 1. This was because each core will have
> > > its own call to rproc_alloc(), rproc_add() and each core's remoteproc
> > > structure has the same parent device.
> > 
> > You haven't specified if my proposal worked with test 2 and 3.  I'm guessing
> > that it does.
> > 
> Sorry, yes tests 2 and 3 work with your proposal.
> > > 
> > > This results in the later call to rproc_get_by_phandle() not behaving
> > > properly because the function will return whichever core had its entries
> > > added to the list first.
> > > 
> > 
> > That is a valid observation, but at least we are getting closer.  The next step
> > is to find the right remote processor and I think we should look at np->name and
> > rproc->name.  They should be quite close because rproc_alloc() is called with
> > dev_name(cdev).
> > 
> > I will look into this further tomorrow morning if I have time, but I encourage
> > you to do the same on your side.
> > 
> 
> For the case where the cluster is in split mode and there are 2 child nodes
> here is my update:
> 
> 1. The rproc_list has 2 entries as follows:
> 	
>   as expected each entry has the same r->dev.parent (E.g. the cluster node)
> 
>   The entries have the  with device name rproc->dev name 'remoteproc0' and
> 'remoteproc1'
> 
> 
> 	
> 2. For my use case I am trying to pass in the phandle of the core node
> (child of the cluster). If I pass in the core node then
> rproc_get_by_phandle() returns NULL because the r->dev.parent->of_node does
> not match. This is expected because at rproc_alloc() we passed in the
> cluster and not the core.
>


I had a serious look into this and trying to do something with the rproc->name and
device_node->name won't work.  As such, I suggest the following (uncompiled and
untested):

struct rproc *rproc_get_by_phandle(phandle phandle)
{
        struct platform_device *cluster_pdev;
	struct rproc *rproc = NULL, *r;
        struct device_driver *driver;
	struct device_node *np;

	np = of_find_node_by_phandle(phandle);
	if (!np)
		return NULL;

	rcu_read_lock();
	list_for_each_entry_rcu(r, &rproc_list, node) {
		if (r->dev.parent && r->dev.parent->of_node == np) {
			/* prevent underlying implementation from being removed */

                        /*
                         * If the remoteproc's parent has a driver, the
                         * remoteproc is not part of a cluster and we can use
                         * that driver.
                         */
                        driver = r->dev.parent->driver;

                        /*
                         * If the remoteproc's parent does not have a driver,
                         * look for the driver associated with the cluster.
                         */
                        if (!driver) {
                                cluster_pdev = of_find_device_by_node(np->parent);
                                if (!cluster_pdev) {
                                        dev_err(&r->dev, "can't get driver\n");
                                        break;
                                }

                                driver = cluster_pdev->dev.parent->driver;
                                put_device(&cluster_pdev->dev);
                        }

			if (!try_module_get(driver->owner)) {
				dev_err(&r->dev, "can't get owner\n");
				break;
			}

			rproc = r;
			get_device(&rproc->dev);
			break;
		}
	}
	rcu_read_unlock();

	of_node_put(np);

	return rproc;
}

Let me know if that works for you.

Thanks,
Mathieu



> np->name in the loop is then name of the cluster node in my sample device
> tree that I booted with that is 'r5f_0' where the cluster is 'rf5ss'.
> 
> If I am trying to get the rproc entry with name 'remoteproc0' and I pass in
> to rproc_get_by_phandle() the cluster node's phandle (that is of rf5ss) then
> the API _does_ work for getting the first entry from the rproc list.
> 
> But If I am trying to the second rproc entry (dev name 'remoteproc1') and I
> pass into rproc_get_by_phandle()  I will still get the 'remoteproc0' entry
> because the phandle of the first entry also matches in the loop.
> 
> Thanks
> Ben
> 
> > > 
> > > For reference I placed the logic for API rproc_get_by_phandle() that loops
> > > through device and the rproc_alloc() line where the dev parent is set:
> > > 
> > > 
> > > Here is the getter API where the loop checking the remoteproc dev parent is:
> > > 
> > > https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2109
> > > 
> > > 
> > > if(r->dev.parent&& r->dev.parent->of_node== np) {
> > > 
> > > 
> > > Here is the rproc_alloc() call where they set remoteproc dev parent:
> > > 
> > > https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2448
> > > 
> > > 
> > > rproc->dev.parent= dev;
> > > 
> > > Thanks,
> > > 
> > > Ben
> > > 
> > 
