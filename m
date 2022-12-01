Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D463F889
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLAToM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Dec 2022 14:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLAToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:44:11 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B9114D04;
        Thu,  1 Dec 2022 11:44:09 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 25ab7833bb94707f; Thu, 1 Dec 2022 20:44:07 +0100
Received: from kreacher.localnet (unknown [213.134.188.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 60D7527C06A2;
        Thu,  1 Dec 2022 20:44:05 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bjorn.andersson@kernel.org, quic_mkshah@quicinc.com,
        quic_lsrao@quicinc.com, bvanassche@acm.org,
        Peter Wang <peter.wang@mediatek.com>
Subject: Re: PM-runtime: supplier looses track of consumer during probe
Date:   Thu, 01 Dec 2022 20:44:03 +0100
Message-ID: <12104185.O9o76ZdvQC@kreacher>
In-Reply-To: <CAJZ5v0gdg=PUz-j0yd_QJRPmjhZ7pCuRrHt30U60H4QyTHCmdA@mail.gmail.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com> <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com> <CAJZ5v0gdg=PUz-j0yd_QJRPmjhZ7pCuRrHt30U60H4QyTHCmdA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.161
X-CLIENT-HOSTNAME: 213.134.188.161
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffelhfeiuefgudelhefftdekfeetkeelvdduhedvgfffhfetudfffeevkefgkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhkmhhlrdhorhhgnecukfhppedvudefrddufeegrddukeekrdduiedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudeiuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudegpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghnihhtihhrrgifrgesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpthhnihhm
 khgrrhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhdrrghnuggvrhhsshhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghmkhhshhgrhhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggplhhsrhgrohesqhhuihgtihhntgdrtghomhdprhgtphhtthhopegsvhgrnhgrshhstghhvgesrggtmhdrohhrghdprhgtphhtthhopehpvghtvghrrdifrghnghesmhgvughirghtvghkrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 1, 2022 8:28:25 PM CET Rafael J. Wysocki wrote:
> On Thu, Dec 1, 2022 at 2:10 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 29/11/22 18:56, Nitin Rawat wrote:
> > > Hi Adrian,
> > >
> > > On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
> > >> Hi Adrian,
> > >>
> > >> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
> > >>> On 4/11/22 11:19, Tushar Nimkar wrote:
> > >>>> Hi linux-pm/linux-scsi,
> > >>
> > >>>>> Process -1
> > >>>>> ufshcd_async_scan context (process 1)
> > >>>>> scsi_autopm_put_device() //0:0:0:0
> > >>>
> > >>> I am having trouble following your description.  What function is calling
> > >>> scsi_autopm_put_device() here?
> > >>>
> > >> Below is flow which calls scsi_autopm_put_device()
> > >> Process -1
> > >> ufshcd_async_scan()
> > >>      scsi_probe_and_add_lun()
> > >>          scsi_add_lun()
> > >>              slave_configure()
> > >>                  scsi_sysfs_add_sdev()
> > >>                      scsi_autopm_get_device()
> > >>                          device_add()     <- invoked [Process 2] sd_probe()
> > >>                              scsi_autopm_put_device()
> > >>
> > >>>>> pm_runtime_put_sync()
> > >>>>> __pm_runtime_idle()
> > >>>>> rpm_idle() -- RPM_GET_PUT(4)
> > >>>>>       __rpm_callback
> > >>>>>           scsi_runtime_idle()
> > >>>>>               pm_runtime_mark_last_busy()
> > >>>>>               pm_runtime_autosuspend()  --[A]
> > >>>>>                   rpm_suspend() -- RPM_AUTO(8)
> > >>>>>                       pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
> > >>>>>                           __update_runtime_status to RPM_SUSPENDING
> > >>>>>                       __rpm_callback()
> > >>>>>                           __rpm_put_suppliers(dev, false)
> > >>>>>                       __update_runtime_status to RPM_SUSPENDED
> > >>>>>                   rpm_suspend_suppliers()
> > >>>>>                       rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
> > >>>>>                   rpm_suspend() – END with return=0
> > >>>>>           scsi_runtime_idle() END return (-EBUSY) always.
> > >>>
> > >>> Not following here either.  Which device is EBUSY and why?
> > >>
> > >> scsi_runtime_idle() return -EBUSY always [3]
> > >> Storage/scsi team can better explain -EBUSY implementation.
> > >
> > > EBUSY is returned from below code for consumer dev 0:0:0:0.
> > > scsi_runtime_idle is called from scsi_autopm_put_device which inturn is called from ufshcd_async_scan (Process 1 as per above call stack)
> > > static int scsi_runtime_idle(struct device *dev)
> > > {
> > >     :
> > >
> > >     if (scsi_is_sdev_device(dev)) {
> > >         pm_runtime_mark_last_busy(dev);
> > >         pm_runtime_autosuspend(dev);
> > >         return -EBUSY; ---> EBUSY returned from here.
> > >     }
> > >
> > >
> > > }
> > >
> > >>
> > >> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
> > >>
> > >>
> > >>>>>
> > >>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
> > >>>>> [2]: https://lkml.org/lkml/2022/10/12/259
> >
> > It looks to me like __rpm_callback() makes assumptions about
> > dev->power.runtime_status that are not necessarily true because
> > dev->power.lock is dropped.
> 
> Well, this happens because rpm_idle() calls __rpm_callback() and
> allows it to run concurrently with rpm_suspend() and rpm_resume(), so
> one of them may change runtime_status to RPM_SUSPENDING or
> RPM_RESUMING while __rpm_callback() is running.
> 
> It is somewhat questionable whether or not this should be allowed to
> happen, but since it is generally allowed to suspend the device from
> its .runtime_idle callback, there is not too much that can be done
> about it.

But this means that the patch below should help too.

I actually think that we can do both, because rpm_idle() doesn't have to do
the whole device links dance and the fact that it still calls __rpm_callback()
is a clear oversight.

---
 drivers/base/power/runtime.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
 
 	dev->power.idle_notification = true;
 
-	retval = __rpm_callback(callback, dev);
+	if (dev->power.irq_safe)
+		spin_unlock(&dev->power.lock);
+	else
+		spin_unlock_irq(&dev->power.lock);
+
+	retval = callback(dev);
+
+	if (dev->power.irq_safe)
+		spin_lock(&dev->power.lock);
+	else
+		spin_lock_irq(&dev->power.lock);
 
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);



