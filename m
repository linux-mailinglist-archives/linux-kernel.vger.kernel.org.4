Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4CC6C439C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCVGvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCVGu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:50:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929F5679C;
        Tue, 21 Mar 2023 23:50:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so68709421edb.11;
        Tue, 21 Mar 2023 23:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679467830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpG/rF53T4RKiFgPnbDmFRsP8hRDR+VIeoG2d8gwVh4=;
        b=p1lOoRzalvz/+FFWVZE9FluXJRkYLROyvUEO9pml31oG5QOr87VGB4iQ4rpFNvsHl8
         Uhznc/satZubE9QOPCQHudapzFKEK6z+DC+1sHZ9bK5eBJqEoAV/qmgluIZEIt5rM344
         +07ag1uyRygbGFDRMNs9XyhZE/IqiDpfoWlWMDKHmvLJ1EVMNbAWUeiHVnGvvdAYIuQx
         NpirrqXEcA6DsFeNDMKriLXBhoH+LOwRqkwF6pZzv/eVTrdvajH2/a7HXyTyuKPjLcdC
         TTzCkt+YbQf4grvCx+V+HMmgQKCtFHPeni9oHQHDTj0codFpRwoDTthXIuhL/1Pzahpl
         BrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpG/rF53T4RKiFgPnbDmFRsP8hRDR+VIeoG2d8gwVh4=;
        b=ddNQEDA0I9jL7wkGDM4nEp4UXPXW/i8XJ0YpwDKIrhDGlA/Nxi5nXnPGibHthLAaxS
         3WHvrDG/nvbBuEYJcWF2fbX5tLPQ1VTxiP0rgvp0Jy7pSqLj6yVr6ooA2k/fF0J9PXxN
         3DDMoorQv4pytxhfs3/q8BiYB0NCKrvswfuBjHU+3EA+jk4GObdmq9s7LrOAkO4hADGN
         o/TQwnueJwHQFrw7y2OilddKpKWVAzC1oeWh3DG34ZT7UQXXeMedAlBkKr+KGxR1RqPV
         T5+9KmaQ9JNocm0uYC/OthD/nsYvEJ0rPUlBoRYDo2KxX2uUVVAX6i8hTJv+zvOF6OVv
         HSyQ==
X-Gm-Message-State: AO0yUKUF72bulotz1OStyFOPDSH9KJnzVcloorEYzF+6etZ9P1k+ugVc
        a+gyYUcbwXIRGOEorWwBeyM=
X-Google-Smtp-Source: AK7set8+r/4/2HzU2tZP371rDWJLHY6wC/W+cbwFVGQPsOBng4qaf2fBAEmRiuVvkVaHleSLdkviZw==
X-Received: by 2002:aa7:c84a:0:b0:500:58cb:3b05 with SMTP id g10-20020aa7c84a000000b0050058cb3b05mr5867668edt.27.1679467829278;
        Tue, 21 Mar 2023 23:50:29 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id kj2-20020a170907764200b009324717b9f3sm6169857ejc.71.2023.03.21.23.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:50:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 22 Mar 2023 07:50:27 +0100
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <ZBqlMxo4/vKYZ08K@pc638.lan>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <SJ1PR11MB61795652651F41A8F94B1E9D89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB61795652651F41A8F94B1E9D89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:49:50AM +0000, Zhuo, Qiuxu wrote:
> Hi Rezki,
> 
> > From: Uladzislau Rezki <urezki@gmail.com>
> > Sent: Tuesday, March 21, 2023 11:16 PM
> > [...]
> > >
> > >
> > > If possible, may I know the steps, commands, and related parameters to
> > produce the results above?
> > > Thank you!
> > >
> > Build the kernel with CONFIG_RCU_TRACE configuration. Update your
> > "set_event"
> > file with appropriate traces:
> > 
> > <snip>
> > XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end
> > rcu:rcu_invoke_callback > set_event
> > 
> > XQ-DQ54:/sys/kernel/tracing # cat set_event rcu:rcu_batch_start
> > rcu:rcu_invoke_callback rcu:rcu_batch_end XQ-DQ54:/sys/kernel/tracing #
> > <snip>
> > 
> > Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 >
> > tracing_on; sleep 10; echo 0 > tracing_on Next problem is how to parse it. Of
> 
> Thanks for the detailed steps to collect the related testing results.
> 
> > course you will not be able to parse megabytes of traces. For that purpose i
> > use a special C trace parser.
> > If you need an example please let me know i can show here.
> >
> 
> Yes, your example parser should save me from a huge amount of traces. ;-)
> Thanks so much for your sharing.
> 
See below the C program. It is ugly but it does what you need. Please have
a look at main function:

<snip>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>

/*
 * Splay-tree implementation to store data: key,value
 * See https://en.wikipedia.org/wiki/Splay_tree
 */
#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
#define container_of(ptr, type, member)			\
({												\
	void *__mptr = (void *)(ptr);					\
	((type *)(__mptr - offsetof(type, member)));	\
})

#define SP_INIT_NODE(node)									\
	((node)->left = (node)->right = (node)->parent = NULL)

struct splay_node {
	struct splay_node *left;
	struct splay_node *right;
	struct splay_node *parent;
	unsigned long val;
};

struct splay_root {
	struct splay_node *sp_root;
};

static inline void
set_parent(struct splay_node *n, struct splay_node *p)
{
	if (n)
		n->parent = p;
}

static inline void
change_child(struct splay_node *p,
	struct splay_node *old, struct splay_node *new)
{
	if (p) {
		if (p->left == old)
			p->left = new;
		else
			p->right = new;
	}
}

/*
 * left rotation of node (r), (rc) is (r)'s right child
 */
static inline struct splay_node *
left_pivot(struct splay_node *r)
{
	struct splay_node *rc;

	/*
	 * set (rc) to be the new root
	 */
	rc = r->right;

	/*
	 * point parent to new left/right child
	 */
	rc->parent = r->parent;

	/*
	 * change child of the p->parent.
	 */
	change_child(r->parent, r, rc);

	/*
	 * set (r)'s right child to be (rc)'s left child
	 */
	r->right = rc->left;

	/*
	 * change parent of rc's left child
	 */
	set_parent(rc->left, r);

	/*
	 * set new parent of rotated node
	 */
	r->parent = rc;

	/*
	 * set (rc)'s left child to be (r)
	 */
	rc->left = r;

	/*
	 * return the new root
	 */
	return rc;
}

/*
 * right rotation of node (r), (lc) is (r)'s left child
 */
static inline struct splay_node *
right_pivot(struct splay_node *r)
{
	struct splay_node *lc;

	/*
	 * set (lc) to be the new root
	 */
	lc = r->left;

	/*
	 * point parent to new left/right child
	 */
	lc->parent = r->parent;

	/*
	 * change child of the p->parent.
	 */
	change_child(r->parent, r, lc);

	/*
	 * set (r)'s left child to be (lc)'s right child
	 */
	r->left = lc->right;

	/*
	 * change parent of lc's right child
	 */
	set_parent(lc->right, r);

	/*
	 * set new parent of rotated node
	 */
	r->parent = lc;

	/*
	 * set (lc)'s right child to be (r)
	 */
	lc->right = r;

	/*
	 * return the new root
	 */
	return lc;
}

static struct splay_node *
top_down_splay(unsigned long vstart,
	struct splay_node *root, struct splay_root *sp_root)
{
	/*
	 * During the splitting process two temporary trees are formed.
	 * "l" contains all keys less than the search key/vstart and "r"
	 * contains all keys greater than the search key/vstart.
	 */
	struct splay_node head, *ltree_max, *rtree_max;
	struct splay_node *ltree_prev, *rtree_prev;

	if (root == NULL)
		return NULL;

	SP_INIT_NODE(&head);
	ltree_max = rtree_max = &head;
	ltree_prev = rtree_prev = NULL;

	while (1) {
		if (vstart < root->val && root->left) {
			if (vstart < root->left->val) {
				root = right_pivot(root);

				if (root->left == NULL)
					break;
			}

			/*
			 * Build right subtree.
			 */
			rtree_max->left = root;
			rtree_max->left->parent = rtree_prev;
			rtree_max = rtree_max->left;
			rtree_prev = root;
			root = root->left;
		} else if (vstart > root->val && root->right) {
			if (vstart > root->right->val) {
				root = left_pivot(root);

				if (root->right == NULL)
					break;
			}

			/*
			 * Build left subtree.
			 */
			ltree_max->right = root;
			ltree_max->right->parent = ltree_prev;
			ltree_max = ltree_max->right;
			ltree_prev = root;
			root = root->right;
		} else {
			break;
		}
	}

	/*
	 * Assemble the tree.
	 */
	ltree_max->right = root->left;
	rtree_max->left = root->right;
	root->left = head.right;
	root->right = head.left;

	set_parent(ltree_max->right, ltree_max);
	set_parent(rtree_max->left, rtree_max);
	set_parent(root->left, root);
	set_parent(root->right, root);
	root->parent = NULL;

	/*
	 * Set new root. Please note it might be the same.
	 */
	sp_root->sp_root = root;
	return sp_root->sp_root;
}

struct splay_node *
splay_search(unsigned long key, struct splay_root *root)
{
	struct splay_node *n;

	n = top_down_splay(key, root->sp_root, root);
	if (n && n->val == key)
		return n;

	return NULL;
}

static bool
splay_insert(struct splay_node *n, struct splay_root *sp_root)
{
	struct splay_node *r;

	SP_INIT_NODE(n);

	r = top_down_splay(n->val, sp_root->sp_root, sp_root);
	if (r == NULL) {
		/* First element in the tree */
		sp_root->sp_root = n;
		return false;
	}

	if (n->val < r->val) {
		n->left = r->left;
		n->right = r;

		set_parent(r->left, n);
		r->parent = n;
		r->left = NULL;
	} else if (n->val > r->val) {
		n->right = r->right;
		n->left = r;

		set_parent(r->right, n);
		r->parent = n;
		r->right = NULL;
	} else {
		/*
		 * Same, indicate as not success insertion.
		 */
		return false;
	}

	sp_root->sp_root = n;
	return true;
}

static bool
splay_delete_init(struct splay_node *n, struct splay_root *sp_root)
{
	struct splay_node *subtree[2];
	unsigned long val = n->val;

	/* 1. Splay the node to the root. */
	n = top_down_splay(n->val, sp_root->sp_root, sp_root);
	if (n == NULL || n->val != val)
		return false;

	/* 2. Save left/right sub-trees. */
	subtree[0] = n->left;
	subtree[1] = n->right;

	/* 3. Now remove the node. */
	SP_INIT_NODE(n);

	if (subtree[0]) {
		/* 4. Splay the largest node in left sub-tree to the root. */
		top_down_splay(val, subtree[0], sp_root);

		/* 5. Attach the right sub-tree as the right child of the left sub-tree. */
		sp_root->sp_root->right = subtree[1];

		/* 6. Update the parent of right sub-tree */
		set_parent(subtree[1], sp_root->sp_root);
	} else {
		/* 7. Left sub-tree is NULL, just point to right one. */
		sp_root->sp_root = subtree[1];
	}

	/* 8. Set parent of root node to NULL. */
	if (sp_root->sp_root)
		sp_root->sp_root->parent = NULL;

	return true;
}

static FILE *
open_perf_script_file(const char *path)
{
	FILE *f = NULL;

	if (path == NULL)
		goto out;

	f = fopen(path, "r");
	if (!f)
		goto out;

out:
	return f;
}

static int
get_one_line(FILE *file, char *buf, size_t len)
{
	int i = 0;

	memset(buf, '\0', len);

	for (i = 0; i < len - 1; i++) {
		int c = fgetc(file);

		if (c == EOF)
			return EOF;

		if (c == '\n')
			break;

		if (c != '\r')
			buf[i] = c;
	}

	return i;
}

static int
read_string_till_string(char *buf, char *out, size_t out_len, char *in, size_t in_len)
{
	int i, j;

	memset(out, '\0', out_len);

	for (i = 0; i < out_len; i++) {
		if (buf[i] != in[0]) {
			out[i] = buf[i];
			continue;
		}

		for (j = 0; j < in_len; j++) {
			if (buf[i + j] != in[j])
				break;
		}

		/* Found. */
		if (j == in_len)
			return 1;
	}

	return 0;
}

/*
 * find pattern is  "something [003] 8640.034785: something"
 */
static inline void
get_cpu_sec_usec_in_string(const char *s, int *cpu, int *sec, int *usec)
{
	char usec_buf[32] = {'\0'};
	char sec_buf[32] = {'\0'};
	char cpu_buf[32] = {'\0'};
	bool found_sec = false;
	bool found_usec = false;
	bool found_cpu = false;
	int i, j, dot;

	*cpu = *sec = *usec = -1;

	for (i = 0, j = 0; s[i] != '\0'; i++) {
		if (s[i] == '.') {
			dot = i++;

			/* take microseconds */
			for (j = 0; j < sizeof(usec_buf); j++) {
				if (isdigit(s[i])) {
					usec_buf[j] = s[i];
				} else {
					if (s[i] == ':' && j > 0)
						found_usec = true;
					else
						found_usec = false;

					/* Terminate here. */
					break;
				}

				i++;
			}

			if (found_usec) {
				/* roll back */
				while (s[i] != ' ' && i > 0)
					i--;

				/* take seconds */
				for (j = 0; j < sizeof(sec_buf); j++) {
					if (isdigit(s[++i])) {
						sec_buf[j] = s[i];
					} else {
						if (s[i] == '.' && j > 0)
							found_sec = true;
						else
							found_sec = false;
						
						/* Terminate here. */
						break;
					}
				}
			}

			if (found_sec && found_usec) {
				/* roll back */
				while (s[i] != '[' && i > 0)
					i--;

				/* take seconds */
				for (j = 0; j < sizeof(cpu_buf); j++) {
					if (isdigit(s[++i])) {
						cpu_buf[j] = s[i];
					} else {
						if (s[i] == ']' && j > 0)
							found_cpu = true;
						else
							found_cpu = false;
						
						/* Terminate here. */
						break;
					}
				}

				if (found_cpu && found_sec && found_usec) {
					*sec = atoi(sec_buf);
					*usec = atoi(usec_buf);
					*cpu = atoi(cpu_buf);
					return;
				}
			}

			/*
			 * Check next dot pattern.
			 */
			found_sec = false;
			found_usec = false;
			found_cpu = false;
			i = dot;
		}
	}
}

/*
 * find pattern is  "something comm=foo android thr1 pid=123 something"
 */
static inline int
get_comm_pid_in_string(const char *buf, char *comm, ssize_t len, int *pid)
{
	char *sc, *sp;
	int rv, i;

	memset(comm, '\0', len);

	sc = strstr(buf, "comm=");
	if (sc)
		sp = strstr(sc, " pid=");

	if (!sc || !sp)
		return -1;

	for (i = 0, sc += 5; sc != sp; i++) {
		if (i < len) {
			if (*sc == ' ')
				comm[i] = '-';
			else
				comm[i] = *sc;

			sc++;
		}
	}

	/* Read pid. */
	rv = sscanf(sp, " pid=%d", pid);
	if (rv != 1)
		return -1;

	return 1;
}

static void
perf_script_softirq_delay(FILE *file, int delay_usec)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "irq:softirq_raise:");
			if (s) {
				char extra[512] = {'\0'};
				int sec_0, usec_0;
				int sec_1, usec_1;
				int handle_vector;
				int rise_vector;
				int cpu_0;
				int cpu_1;

				/*
				 * swapper     0    [000]  6010.619854:  irq:softirq_raise: vec=7 [action=SCHED]
				 * android.bg  3052 [001]  6000.076212:  irq:softirq_entry: vec=9 [action=RCU]
				 */
				(void) sscanf(s, "%s vec=%d", extra, &rise_vector);
				get_cpu_sec_usec_in_string(buf, &cpu_0, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					s = strstr(buf_1, "irq:softirq_entry:");
					if (s) {
						(void) sscanf(s, "%s vec=%d", extra, &handle_vector);
						get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);

						if (cpu_0 == cpu_1 && rise_vector == handle_vector) {
							int delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);

							if (delta_time_usec > delay_usec)
								fprintf(stdout, "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
							break;
						}
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}
}

static void
perf_script_softirq_duration(FILE *file, int duration_usec)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "irq:softirq_entry:");
			if (s) {
				char extra[512] = {'\0'};
				int sec_0, usec_0;
				int sec_1, usec_1;
				int handle_vector;
				int rise_vector;
				int cpu_0;
				int cpu_1;

				/*
				 * swapper     0    [000]  6010.619854:  irq:softirq_entry: vec=7 [action=SCHED]
				 * android.bg  3052 [001]  6000.076212:  irq:softirq_exit: vec=9 [action=RCU]
				 */
				(void) sscanf(s, "%s vec=%d", extra, &rise_vector);
				get_cpu_sec_usec_in_string(buf, &cpu_0, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					s = strstr(buf_1, "irq:softirq_exit:");
					if (s) {
						(void) sscanf(s, "%s vec=%d", extra, &handle_vector);
						get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);

						if (cpu_0 == cpu_1 && rise_vector == handle_vector) {
							int delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);

							if (delta_time_usec > duration_usec)
								fprintf(stdout, "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
							break;
						}
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}
}

static void
perf_script_hardirq_duration(FILE *file, int duration_msec)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "irq:irq_handler_entry:");
			if (s) {
				char extra[512] = {'\0'};
				int sec_0, usec_0;
				int sec_1, usec_1;
				int handle_vector;
				int rise_vector;
				int cpu_0;
				int cpu_1;

				/*
				 * swapper     0 [002]  6205.804133: irq:irq_handler_entry: irq=11 name=arch_timer
				 * swapper     0 [002]  6205.804228:  irq:irq_handler_exit: irq=11 ret=handled
				 */
				(void) sscanf(s, "%s irq=%d", extra, &rise_vector);
				get_cpu_sec_usec_in_string(buf, &cpu_0, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					s = strstr(buf_1, "irq:irq_handler_exit:");
					if (s) {
						(void) sscanf(s, "%s irq=%d", extra, &handle_vector);
						get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);

						if (cpu_0 == cpu_1 && rise_vector == handle_vector) {
							int delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);

							if (delta_time_usec > duration_msec)
								fprintf(stdout, "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
							break;
						}
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}
}

struct irq_stat {
	int irq;
	int count;
	char irq_name[512];

	int min_interval;
	int max_interval;
	int avg_interval;

	unsigned int time_stamp_usec;
	struct splay_node node;
};

static struct irq_stat *
new_irq_node_init(int irq, char *irq_name)
{
	struct irq_stat *n = calloc(1, sizeof(*n));

	if (n) {
		n->irq = irq;
		(void) strncpy(n->irq_name, irq_name, sizeof(n->irq_name));
		n->node.val = irq;
	}

	return n;
}

static void
perf_script_hardirq_stat(FILE *file)
{
	struct splay_root sproot = { NULL };
	struct irq_stat *node;
	char buf[4096] = { '\0' };
	char extra[256] = {'\0'};
	char irq_name[256] = {'\0'};
	unsigned int time_stamp_usec;
	int cpu, sec, usec;
	int rv, irq;
	char *s;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		if (rv == EOF)
			break;

		 s = strstr(buf, "irq:irq_handler_entry:");
		 if (s == NULL)
			 continue;

		 /*
		  * format is as follow one:
		  * sleep  1418 [003]  8780.957112:             irq:irq_handler_entry: irq=11 name=arch_timer
		  */
		 rv = sscanf(s, "%s irq=%d name=%s", extra, &irq, irq_name);
	 	 if (rv != 3)
	 		 continue;

		 get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
		 time_stamp_usec = (sec * 1000000) + usec;

		 if (sproot.sp_root == NULL) {
			 node = new_irq_node_init(irq, irq_name);
			 if (node)
				 splay_insert(&node->node, &sproot);
		 }

		 top_down_splay(irq, sproot.sp_root, &sproot);
		 node = container_of(sproot.sp_root, struct irq_stat, node);

		 /* Found the entry in the tree. */
		 if (node->irq == irq) {
			 if (node->time_stamp_usec) {
				 unsigned int delta = time_stamp_usec - node->time_stamp_usec;

				 if (delta < node->min_interval || !node->min_interval)
					 node->min_interval = delta;

				 if (delta > node->max_interval)
					 node->max_interval = delta;

				 node->avg_interval += delta;
			 }

			 /* Save the last time for this IRQ entry. */
			 node->time_stamp_usec = time_stamp_usec;
		 } else {
			 /* Allocate a new record and place it to the tree. */
			 node = new_irq_node_init(irq, irq_name);
			 if (node)
				 splay_insert(&node->node, &sproot);

		 }

		 /* Update the timestamp for this entry. */
		 node->time_stamp_usec = time_stamp_usec;
		 node->count++;
	}

	/* Dump the tree. */
	while (sproot.sp_root) {
		node = container_of(sproot.sp_root, struct irq_stat, node);

		fprintf(stdout, "irq: %5d name: %30s count: %7d, min: %10d, max: %10d, avg: %10d\n",
				node->irq, node->irq_name, node->count,
				node->min_interval, node->max_interval, node->avg_interval / node->count);

		splay_delete_init(&node->node, &sproot);
		free(node);
	}

	fprintf(stdout, "\tRun './a.out ./perf.script | sort -nk 6' to sort by column 6.\n");
}

struct sched_waking {
	unsigned int wakeup_nr;
	char comm[4096];
	int pid;

	int min;
	int max;
	int avg;

	unsigned int time_stamp_usec;
	struct splay_node node;
};

static struct sched_waking *
new_sched_waking_node_init(int pid, char *comm)
{
	struct sched_waking *n = calloc(1, sizeof(*n));

	if (n) {
		n->pid = pid;
		(void) strncpy(n->comm, comm, sizeof(n->comm));
		n->node.val = pid;
	}

	return n;
}

/*
 * How many times a task is awaken + min/max/avg stat.
 */
static void
perf_script_sched_waking_stat(const char *name, FILE *file, const char *script)
{
	struct splay_root sroot = { NULL };
	struct sched_waking *n;
	char buf[4096] = { '\0' };
	char comm[256] = {'\0'};
	unsigned int time_stamp_usec;
	unsigned int total_waking = 0;
	int cpu, sec, usec;
	int rv, pid;
	char *s;
	
	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		if (rv == EOF)
			break;
		/*
		 * format is as follow one:
		 * foo[1] 7521 [002] 10.431216: sched_waking: comm=tr pid=2 prio=120 target_cpu=006
		 */
		s = strstr(buf, "sched_waking:");
		if (s == NULL)
			continue;

		rv = get_comm_pid_in_string(s, comm, sizeof(comm), &pid);
		if (rv < 0) {
			printf("ERROR: skip entry...\n");
			continue;
		}

		get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
		time_stamp_usec = (sec * 1000000) + usec;

		if (sroot.sp_root == NULL) {
			n = new_sched_waking_node_init(pid, comm);
			if (n)
				splay_insert(&n->node, &sroot);
		}

		top_down_splay(pid, sroot.sp_root, &sroot);
		n = container_of(sroot.sp_root, struct sched_waking, node);

		/* Found the entry in the tree. */
		if (n->pid == pid) {
			if (n->time_stamp_usec) {
				unsigned int delta = time_stamp_usec - n->time_stamp_usec;

				if (delta < n->min || !n->min)
					n->min = delta;

				if (delta > n->max)
					n->max = delta;

				n->avg += delta;
			}

			/* Save the last time for this wake-up entry. */
			n->time_stamp_usec = time_stamp_usec;
		} else {
			/* Allocate a new record and place it to the tree. */
			n = new_sched_waking_node_init(pid, comm);
			if (n)
				splay_insert(&n->node, &sroot);
		}

		/* Update the timestamp for this entry. */
		n->time_stamp_usec = time_stamp_usec;
		n->wakeup_nr++;
	}

	/* Dump the Splay-tree. */
	while (sroot.sp_root) {
		n = container_of(sroot.sp_root, struct sched_waking, node);
		fprintf(stdout, "name: %30s pid: %10d woken-up %5d\tinterval: min %5d\tmax %5d\tavg %5d\n",
			n->comm, n->pid, n->wakeup_nr,
			n->min, n->max, n->avg / n->wakeup_nr);

		total_waking += n->wakeup_nr;
		splay_delete_init(&n->node, &sroot);
		free(n);
	}

	fprintf(stdout, "=== Total: %u ===\n", total_waking);
	fprintf(stdout, "\tRun './%s %s | sort -nk 6' to sort by column 6.\n", name, script);
}

/*
 * Latency of try_to_wake_up path + select a CPU + placing a task into run-queue.
 */
static void
perf_script_sched_wakeup_latency(const char *name, FILE *file, const char *script)
{
	struct splay_root sroot = { NULL };
	struct splay_node *node;
	struct sched_waking *n;
	char buf[4096] = { '\0' };
	char comm[256] = {'\0'};
	unsigned int time_stamp_usec;
	unsigned int wakeup_latency_usec;
	unsigned int total_waking = 0;
	int cpu, sec, usec;
	int rv, pid;
	char *sched_waking_wakeup;
	bool sched_waking_event;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		if (rv == EOF)
			break;

		/*
		 * format is as follow one:
		 * foo[1] 7521 [002] 10.431216: sched_waking: comm=tr pid=2 prio=120 target_cpu=006
		 */
		sched_waking_wakeup = strstr(buf, "sched_waking:");
		sched_waking_event = !!sched_waking_wakeup;

		if (!sched_waking_event) {
			/*
			 * format is as follow one:
			 * foo[1] 7521 [002] 10.431216: sched_wakeup: comm=tr pid=2 prio=120 target_cpu=006
			 */
			sched_waking_wakeup = strstr(buf, "sched_wakeup:");
			if (sched_waking_wakeup == NULL)
				continue;
		}

		rv = get_comm_pid_in_string(sched_waking_wakeup, comm, sizeof(comm), &pid);
		if (rv < 0) {
			printf("ERROR: skip entry...\n");
			continue;
		}

		get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
		time_stamp_usec = (sec * 1000000) + usec;

		/*
		 * Let's check if it exists, if so update it
		 * otherwise create a new node and insert.
		 */
		if (sched_waking_event) {
			node = top_down_splay(pid, sroot.sp_root, &sroot);
			if (node == NULL) {
				n = new_sched_waking_node_init(pid, comm);
				splay_insert(&n->node, &sroot);
			} else {
				n = container_of(node, struct sched_waking, node);
				if (n->pid != pid) {
					n = new_sched_waking_node_init(pid, comm);
					splay_insert(&n->node, &sroot);
				}
			}

			n->time_stamp_usec = time_stamp_usec;
			continue;
		}

		node = top_down_splay(pid, sroot.sp_root, &sroot);
		if (node == NULL) {
			fprintf(stdout, "error: no sched_waking event for %d pid yet.\n", pid);
			continue;
		}

		n = container_of(node, struct sched_waking, node);
		if (n->pid != pid) {
			fprintf(stdout, "error: sched_wakeup event does not match with any sched_waking event.\n");
			continue;
		}

		wakeup_latency_usec = time_stamp_usec - n->time_stamp_usec;

		if (wakeup_latency_usec < n->min || !n->min)
			n->min = wakeup_latency_usec;

		if (wakeup_latency_usec > n->max)
			n->max = wakeup_latency_usec;

		if (n->avg + wakeup_latency_usec < n->avg)
			fprintf(stdout, "error: counter is overflowed...\n");

		fprintf(stdout, "%s: %d wake-up latency: %u waken on %d CPU\n", comm, pid, wakeup_latency_usec, cpu);

		n->avg += wakeup_latency_usec;
		n->wakeup_nr++;
	}

	/* Dump the Splay-tree. */
	while (sroot.sp_root) {
		n = container_of(sroot.sp_root, struct sched_waking, node);
		/* fprintf(stdout, "name: %30s pid: %10d woken-up %5d\twakeup-latency: min %5d\tmax %5d\tavg %5d\n", */
		/* 	n->comm, n->pid, n->wakeup_nr, */
		/* 	n->min, n->max, n->avg / n->wakeup_nr); */

		total_waking += n->wakeup_nr;
		splay_delete_init(&n->node, &sroot);
		free(n);
	}

	/* fprintf(stdout, "=== Total: %u ===\n", total_waking); */
	/* fprintf(stdout, "\tRun '%s %s | sort -nk 6' to sort by column 6.\n", name, script); */
}


/*
 * Requires:
 *   rcu:rcu_batch_start
 *   rcu:rcu_invoke_callback
 *   rcu:rcu_batch_end
 */
static void
perf_script_synchronize_rcu_latency(const char *name, FILE *file, const char *script)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "rcu_batch_start:");
			if (s) {
				int delta_time_usec;
				int sec_0, usec_0;
				int sec_1, usec_1;
				int pid_0, pid_1;
				int extra;

				/*
				 * rcuop/5-58      [007] d..1.  6111.808748: rcu_batch_start: rcu_preempt CBs=23 bl=10
				 */
				(void) sscanf(buf, "%*[^0-9]%d-%d", &pid_0, &pid_0);
				get_cpu_sec_usec_in_string(buf, &extra, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					/* Do not care what a string format is on this step. */
					(void) sscanf(buf, "%*[^0-9]%d-%d", &pid_1, &pid_1);

					/*
					 * rcuop/4-51      [007] d..1.  6111.816758: rcu_batch_end: rcu_preempt CBs-invoked=1 idle=....
					 */
					s = strstr(buf_1, "rcu_batch_end:");
					if (s && pid_0 == pid_1)
						break;

					/*
					 * rcuop/1-29      [005] .....  6111.808745: rcu_invoke_callback: rcu_preempt rhp=0000000093881c60 func=file_free_rcu.cfi_jt
					 */
					s = strstr(buf_1, "rcu_invoke_callback:");
					if (!s || pid_0 != pid_1)
						continue;

					s = strstr(buf_1, "wakeme_after_rcu");
					if (s) {
						get_cpu_sec_usec_in_string(buf_1, &extra, &sec_1, &usec_1);
						delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);
						fprintf(stdout, "{\n%s\n%s\n} latency %d usec\n", buf, buf_1, delta_time_usec);
						break;
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}

}

int main(int argc, char **argv)
{
	FILE *file;

	file = open_perf_script_file(argv[1]);
	if (file == NULL) {
		fprintf(stdout, "%s:%d failed: specify a perf script file\n", __func__, __LINE__);
		exit(-1);
	}

	/* perf_script_softirq_delay(file, 1000); */
	/* perf_script_softirq_duration(file, 500); */
	/* perf_script_hardirq_duration(file, 500); */
	/* perf_script_hardirq_stat(file); */
	/* perf_script_sched_waking_stat(argv[0], file, argv[1]); */
	/* perf_script_sched_wakeup_latency(argv[0], file, argv[1]); */
	perf_script_synchronize_rcu_latency(argv[0], file, argv[1]);

	return 0;
}
<snip>

Running it as "./a.out app_launch_rcu_trace.txt" will produce below results:

<snip>
...
{
    <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
    <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
} latency 7270 usec
{
    rcuop/5-58      [005] d..1. 21951.352767: rcu_batch_start: rcu_preempt CBs=3 bl=10
    rcuop/5-58      [005] ..... 21951.352768: rcu_invoke_callback: rcu_preempt rhp=00000000b995fac1 func=wakeme_after_rcu.cfi_jt
} latency 1 usec
{
    rcuop/6-65      [007] d..1. 21951.804768: rcu_batch_start: rcu_preempt CBs=5 bl=10
    rcuop/6-65      [007] ..... 21951.804769: rcu_invoke_callback: rcu_preempt rhp=00000000b995fac1 func=wakeme_after_rcu.cfi_jt
} latency 1 usec
{
    rcuop/7-72      [006] d..1. 21951.884774: rcu_batch_start: rcu_preempt CBs=3517 bl=27
    rcuop/7-72      [006] ..... 21951.885979: rcu_invoke_callback: rcu_preempt rhp=000000005119eccc func=wakeme_after_rcu.cfi_jt
} latency 1205 usec
{
    rcuop/5-58      [007] d..1. 21951.912853: rcu_batch_start: rcu_preempt CBs=193 bl=10
    rcuop/5-58      [007] ..... 21951.912975: rcu_invoke_callback: rcu_preempt rhp=00000000b995fac1 func=wakeme_after_rcu.cfi_jt
} latency 122 usec
...
<snip>

now you have a pair.

--
Uladzislau Rezki

