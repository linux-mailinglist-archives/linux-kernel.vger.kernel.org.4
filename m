Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5EE5B6DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiIMMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiIMMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:51:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D75222BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:51:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DCLHKd015280;
        Tue, 13 Sep 2022 12:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qr9k6CbIr16Izhen6+Bzu/5SAmfr275ch08XiOzawI4=;
 b=Se/+aMb71jofE70OLfIA84psrUq8XH/DsEntivV13TFH+9E8290i1VVr7h9UBDs21qUV
 0EJ+n0CE+vCbzmbjGgGoIZsU3Anw5KUJ4Ll0wHXjzx68kzx0fegfBQd1PYWELrLlDjUO
 MMyVwQYUyVSXA+mV5nV5j2Hz/RPVcH+83HoO7++24TttzD+wCDRaswb3qduE12pLaWKz
 HknnPMhc+QLrk1/hscL2a7tLpOC7wb25QUKlsJTQDYsG35mkhbonM2+faLTMZtyA0f5I
 iSZqwRyQwodlbuvhhYvYKXwqq2o+N20aS6C3Gxz/pabKyYo+mjeOZWJhVt8FCSh69MUn zw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjn0sh31e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:50:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DCod3X017107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:50:39 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 05:50:37 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <johannes@sipsolutions.net>, <sboyd@kernel.org>
CC:     <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [RESEND PATCH v5] devcoredump : Serialize devcd_del work
Date:   Tue, 13 Sep 2022 18:20:24 +0530
Message-ID: <1663073424-13663-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5rnpxR8eF15B0iJ7nz1ntvOPBVs-7Nj0
X-Proofpoint-ORIG-GUID: 5rnpxR8eF15B0iJ7nz1ntvOPBVs-7Nj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_05,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In following scenario(diagram), when one thread X running dev_coredumpm()
adds devcd device to the framework which sends uevent notification to
userspace and another thread Y reads this uevent and call to
devcd_data_write() which eventually try to delete the queued timer that
is not initialized/queued yet.

So, debug object reports some warning and in the meantime, timer is
initialized and queued from X path. and from Y path, it gets reinitialized
again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.

To fix this, introduce mutex and a boolean flag to serialize the behaviour.

 	cpu0(X)			                cpu1(Y)

    dev_coredump() uevent sent to user space
    device_add()  ======================> user space process Y reads the
                                          uevents writes to devcd fd
                                          which results into writes to

                                         devcd_data_write()
                                           mod_delayed_work()
                                             try_to_grab_pending()
                                               del_timer()
                                                 debug_assert_init()
   INIT_DELAYED_WORK()
   schedule_delayed_work()
                                                   debug_object_fixup()
                                                     timer_fixup_assert_init()
                                                       timer_setup()
                                                         do_init_timer()
                                                       /*
                                                        Above call reinitializes
                                                        the timer to
                                                        timer->entry.pprev=NULL
                                                        and this will be checked
                                                        later in timer_pending() call.
                                                       */
                                                 timer_pending()
                                                  !hlist_unhashed_lockless(&timer->entry)
                                                    !h->pprev
                                                /*
                                                  del_timer() checks h->pprev and finds
                                                  it to be NULL due to which
                                                  try_to_grab_pending() stucks.
                                                */

Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Hi,

Resending it after rebase. There is no change compare to last v5 version.

v4->v5:
 - Rebased it.

v3->v4:
 - flg variable renamed to delete_work.

v2->v3:
 Addressed comments from gregkh
 - Wrapped the commit text and corrected the alignment.
 - Described the reason to introduce new variables.
 - Restored the blank line.
 - rename the del_wk_queued to flg.
 Addressed comments from tglx
 - Added a comment which explains the race which looks obvious however
   would not occur between disabled_store and devcd_del work.


v1->v2:
 - Added del_wk_queued flag to serialize the race between devcd_data_write()
   and disabled_store() => devcd_free().

 drivers/base/devcoredump.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d..1c06781 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -25,6 +25,47 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
+	/*
+	 * Here, mutex is required to serialize the calls to del_wk work between
+	 * user/kernel space which happens when devcd is added with device_add()
+	 * and that sends uevent to user space. User space reads the uevents,
+	 * and calls to devcd_data_write() which try to modify the work which is
+	 * not even initialized/queued from devcoredump.
+	 *
+	 *
+	 *
+	 *        cpu0(X)                                 cpu1(Y)
+	 *
+	 *        dev_coredump() uevent sent to user space
+	 *        device_add()  ======================> user space process Y reads the
+	 *                                              uevents writes to devcd fd
+	 *                                              which results into writes to
+	 *
+	 *                                             devcd_data_write()
+	 *                                               mod_delayed_work()
+	 *                                                 try_to_grab_pending()
+	 *                                                   del_timer()
+	 *                                                     debug_assert_init()
+	 *       INIT_DELAYED_WORK()
+	 *       schedule_delayed_work()
+	 *
+	 *
+	 * Also, mutex alone would not be enough to avoid scheduling of
+	 * del_wk work after it get flush from a call to devcd_free()
+	 * mentioned as below.
+	 *
+	 *	disabled_store()
+	 *        devcd_free()
+	 *          mutex_lock()             devcd_data_write()
+	 *          flush_delayed_work()
+	 *          mutex_unlock()
+	 *                                   mutex_lock()
+	 *                                   mod_delayed_work()
+	 *                                   mutex_unlock()
+	 * So, delete_work flag is required.
+	 */
+	struct mutex mutex;
+	bool delete_work;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -84,7 +125,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work) {
+		devcd->delete_work = true;
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
 
 	return count;
 }
@@ -112,7 +158,12 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work)
+		devcd->delete_work = true;
+
 	flush_delayed_work(&devcd->del_wk);
+	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -122,6 +173,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
+/*
+ *
+ *	disabled_store()                                	worker()
+ *	 class_for_each_device(&devcd_class,
+ *		NULL, NULL, devcd_free)
+ *         ...
+ *         ...
+ *	   while ((dev = class_dev_iter_next(&iter))
+ *                                                             devcd_del()
+ *                                                               device_del()
+ *                                                                 put_device() <- last reference
+ *             error = fn(dev, data)                           devcd_dev_release()
+ *             devcd_free(dev, data)                           kfree(devcd)
+ *             mutex_lock(&devcd->mutex);
+ *
+ *
+ * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * running devcd_del() and result in memory abort while acquiring devcd->mutex which
+ * is called after kfree of devcd memory  after dropping its last reference with
+ * put_device(). However, this will not happens as fn(dev, data) runs
+ * with its own reference to device via klist_node so it is not its last reference.
+ * so, above situation would not occur.
+ */
+
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -278,13 +353,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
+	devcd->delete_work = false;
 
+	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
+	mutex_lock(&devcd->mutex);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -301,10 +379,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-
+	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
 	put_device(&devcd->devcd_dev);
+	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
-- 
2.7.4

