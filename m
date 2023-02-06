Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C053468BFC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjBFOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBFOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:14:19 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65242202E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:13:48 -0800 (PST)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 316EDe2k010619;
        Mon, 6 Feb 2023 23:13:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Mon, 06 Feb 2023 23:13:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 316EDdFc010615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Feb 2023 23:13:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
Date:   Mon, 6 Feb 2023 23:13:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/05 10:23, Alan Stern wrote:
> I suppose we could create separate lockdep classes for every bus_type 
> and device_type combination, as well as for the different sorts of 
> devices -- treat things like class devices separately from normal 
> devices, and so on.  But even then there would be trouble.

Sorry, since I'm not familiar with devices, I can't interpret what you
are talking about in this response. But why don't you try test5() approach
in an example module shown below (i.e. treat all dev->mutex instances
independent to each other) ?

Sharing mutex_init() (like test2() approach) causes false positives,
but allocating a key on each dev->mutex (like test5() approach) should
avoid false positives.

----------
#include <linux/module.h>
#include <linux/slab.h>

static struct mutex *alloc_mutex(void)
{
	return kzalloc(sizeof(struct mutex), GFP_KERNEL | __GFP_NOFAIL);
}

static void free_mutex(struct mutex *m)
{
	kfree(m);
}

static void test1(void)
{
	struct mutex *parent_mutex;
	struct mutex *peer_mutex[4];
	int i;

	pr_info("Running %s\n", __func__);
	parent_mutex = alloc_mutex();
	mutex_init(parent_mutex);

	peer_mutex[0] = alloc_mutex();
	mutex_init(peer_mutex[0]);
	peer_mutex[1] = alloc_mutex();
	mutex_init(peer_mutex[1]);
	peer_mutex[2] = alloc_mutex();
	mutex_init(peer_mutex[2]);
	peer_mutex[3] = alloc_mutex();
	mutex_init(peer_mutex[3]);

	mutex_lock(parent_mutex);
	for (i = 0; i < 4; i++)
		mutex_lock(peer_mutex[i]);
	for (i = 0; i < 4; i++)
		mutex_unlock(peer_mutex[i]);
	mutex_unlock(parent_mutex);
	for (i = 0; i < 4; i++)
		free_mutex(peer_mutex[i]);
	free_mutex(parent_mutex);
}

static void test2(void)
{
	struct mutex *parent_mutex;
	struct mutex *peer_mutex[4];
	int i;

	pr_info("Running %s\n", __func__);
	parent_mutex = alloc_mutex();
	mutex_init(parent_mutex);
	for (i = 0; i < 4; i++) {
		peer_mutex[i] = alloc_mutex();
		mutex_init(peer_mutex[i]);
	}
	mutex_lock(parent_mutex);
	for (i = 0; i < 4; i++)
		mutex_lock(peer_mutex[i]);
	for (i = 0; i < 4; i++)
		mutex_unlock(peer_mutex[i]);
	mutex_unlock(parent_mutex);
	for (i = 0; i < 4; i++)
		free_mutex(peer_mutex[i]);
	free_mutex(parent_mutex);
}

static void test3(void)
{
	struct mutex *parent_mutex;
	struct mutex *peer_mutex[4];
	int i;

	pr_info("Running %s\n", __func__);
	parent_mutex = alloc_mutex();
	mutex_init(parent_mutex);
	for (i = 0; i < 4; i++) {
		peer_mutex[i] = alloc_mutex();
		switch (i) {
		case 0:
			mutex_init(peer_mutex[i]);
			break;
		case 1:
			mutex_init(peer_mutex[i]);
			break;
		case 2:
			mutex_init(peer_mutex[i]);
			break;
		case 3:
			mutex_init(peer_mutex[i]);
			break;
		}
	}
	mutex_lock(parent_mutex);
	for (i = 0; i < 4; i++)
		mutex_lock(peer_mutex[i]);
	for (i = 0; i < 4; i++)
		mutex_unlock(peer_mutex[i]);
	mutex_unlock(parent_mutex);
	for (i = 0; i < 4; i++)
		free_mutex(peer_mutex[i]);
	free_mutex(parent_mutex);
}

static void test4(void)
{
	struct mutex *parent_mutex;
	struct mutex *peer_mutex[4];
	int i;

	pr_info("Running %s\n", __func__);
	parent_mutex = alloc_mutex();
	mutex_init(parent_mutex);
	for (i = 0; i < 4; i++) {
		peer_mutex[i] = alloc_mutex();
		switch (i) {
		case 0:
			mutex_init(peer_mutex[i]);
			break;
		case 1:
			mutex_init(peer_mutex[i]);
			break;
		case 2:
			mutex_init(peer_mutex[i]);
			break;
		case 3:
			mutex_init(peer_mutex[i]);
			break;
		}
	}
	mutex_lock(parent_mutex);
	for (i = 0; i < 4; i++)
		mutex_lock(peer_mutex[i]);
	for (i = 0; i < 4; i++)
		mutex_unlock(peer_mutex[i]);
	for (i = 3; i >= 0; i--)
		mutex_lock(peer_mutex[i]);
	for (i = 3; i >= 0; i--)
		mutex_unlock(peer_mutex[i]);
	mutex_unlock(parent_mutex);
	for (i = 0; i < 4; i++)
		free_mutex(peer_mutex[i]);
	free_mutex(parent_mutex);
}

struct mutex2 {
	struct mutex mutex;
	struct lock_class_key key;
};

static struct mutex2 *alloc_mutex2(void)
{
	struct mutex2 *m = kzalloc(sizeof(struct mutex2), GFP_KERNEL | __GFP_NOFAIL);

	lockdep_register_key(&m->key);
	mutex_init(&m->mutex);
	lockdep_set_class(&m->mutex, &m->key);
	return m;
}

static void free_mutex2(struct mutex2 *m)
{
	mutex_destroy(&m->mutex);
	lockdep_unregister_key(&m->key);
	kfree(m);
}

static void test5(void)
{
	struct mutex2 *parent_mutex;
	struct mutex2 *peer_mutex[4];
	int i;

	pr_info("Running %s\n", __func__);
	parent_mutex = alloc_mutex2();
	for (i = 0; i < 4; i++)
		peer_mutex[i] = alloc_mutex2();
	mutex_lock(&parent_mutex->mutex);
	for (i = 0; i < 4; i++)
		mutex_lock(&peer_mutex[i]->mutex);
	for (i = 0; i < 4; i++)
		mutex_unlock(&peer_mutex[i]->mutex);
	mutex_unlock(&parent_mutex->mutex);
	for (i = 0; i < 4; i++)
		free_mutex2(peer_mutex[i]);
	free_mutex2(parent_mutex);
}

static void test6(void)
{
	struct mutex2 *parent_mutex;
	struct mutex2 *peer_mutex[4];
	int i;

	pr_info("Running %s\n", __func__);
	parent_mutex = alloc_mutex2();
	for (i = 0; i < 4; i++)
		peer_mutex[i] = alloc_mutex2();
	mutex_lock(&parent_mutex->mutex);
	for (i = 0; i < 4; i++)
		mutex_lock(&peer_mutex[i]->mutex);
	for (i = 0; i < 4; i++)
		mutex_unlock(&peer_mutex[i]->mutex);
	for (i = 3; i >= 0; i--)
		mutex_lock(&peer_mutex[i]->mutex);
	for (i = 3; i >= 0; i--)
		mutex_unlock(&peer_mutex[i]->mutex);
	mutex_unlock(&parent_mutex->mutex);
	for (i = 0; i < 4; i++)
		free_mutex2(peer_mutex[i]);
	free_mutex2(parent_mutex);
}

static int __init lockdep_test_init(void)
{
	if (1)
		test1(); // safe and lockdep does not complain
	if (0)
		test2(); // safe but lockdep complains
	if (1)
		test3(); // safe and lockdep does not complain
	if (0)
		test4(); // unsafe and lockdep complains
	if (1)
		test5(); // safe and lockdep does not complain
	if (0)
		test6(); // unsafe and lockdep complains
        return -EINVAL;
}

module_init(lockdep_test_init);
MODULE_LICENSE("GPL");
----------

